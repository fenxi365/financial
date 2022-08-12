package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.common.SubjectExcelUtils;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.model.vo.SubjectVo;
import cn.gson.financial.kernel.service.SubjectService;
import cn.gson.financial.kernel.service.VoucherDetailsService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年07月30日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@RestController
@RequestMapping("/subject")
public class SubjectController extends BaseCrudController<SubjectService, Subject> {

    @Autowired
    private VoucherDetailsService voucherDetailsService;

    @Autowired
    private SubjectExcelUtils excelUtils;

    @Override
    public JsonResult list(@RequestParam Map<String, String> params) {
        QueryWrapper qw = new QueryWrapper<>();
        this.setQwAccountSetsId(qw);
        qw.allEq(params);
        return JsonResult.successful(service.listVo(qw));
    }


    @RequestMapping("select")
    public JsonResult select(@RequestParam Map<String, String> params) {
        QueryWrapper qw = new QueryWrapper<>();
        this.setQwAccountSetsId(qw);
        return JsonResult.successful(service.listVo(qw));
    }
    /**
     * 凭证下拉数据
     *
     * @return
     */
    @RequestMapping("voucher/select")
    public JsonResult voucherSelect(@RequestParam(defaultValue = "0") boolean showAll) {
        QueryWrapper qw = Wrappers.query();
        this.setQwAccountSetsId(qw);
        List data = service.selectData(qw, showAll);
        return JsonResult.successful(data);
    }

    @RequestMapping("loadByCode")
    public JsonResult loadByCode(String[] code, Integer checkYear, Integer checkMonth, String name) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, checkYear);
        cal.set(Calendar.MONTH, checkMonth - 1);

        QueryWrapper qw = Wrappers.query();
        this.setQwAccountSetsId(qw);

        qw.and(wrapper -> {
            QueryWrapper qwe = (QueryWrapper) wrapper;
            for (String s : code) {
                qwe.or(true).likeRight("code", s);
            }
            if ("结转损益".equals(name)) {
                qwe.or(true).eq("type", "损益");
            }
            return wrapper;
        });

        List<Subject> subjects = service.list(qw);
        List<SubjectVo> vos = subjects.stream().distinct().collect(ArrayList::new, (list, source) -> {
            SubjectVo vo = new SubjectVo();
            BeanUtils.copyProperties(source, vo);
            list.add(vo);
        }, List::addAll);

        Map<String, SubjectVo> collect1 = vos.stream().distinct().collect(Collectors.toMap(SubjectVo::getCode, subjectVo -> subjectVo));

        for (String s : code) {
            SubjectVo sbj = collect1.get(s);
            if (sbj.getLevel() != 1) {
                this.recursiveParent(vos, sbj.getParentId());
            }
        }

        Map<Integer, SubjectVo> collect = vos.stream().distinct().collect(Collectors.toMap(SubjectVo::getId, subject -> subject));

        vos.forEach(subject -> {
            if (subject.getLevel() != 1) {
                SubjectVo parent = collect.get(subject.getParentId());
                parent.getChildren().add(subject);
            }
        });


        if (vos.size() > code.length) {
            List<SubjectVo> collect2 = vos.stream().filter(subjectVo -> subjectVo.getChildren().isEmpty()).collect(Collectors.toList());
            for (Subject subjectVo : collect2) {
                if (subjectVo.getLevel() != 1) {
                    this.recursiveChildren(collect, subjectVo, subjectVo.getParentId());
                }
            }
            vos = collect2;
        }

        List<SubjectVo> collect2 = vos.stream().sorted(Comparator.comparing(Subject::getCode)).distinct().collect(Collectors.toList());

        Set<String> codeSet = collect2.stream().collect(Collectors.mapping(subjectVo -> subjectVo.getCode(), Collectors.toSet()));

        Map<String, VoucherDetails> aggregateAmount = voucherDetailsService.getAggregateAmount(this.accountSetsId.get(), codeSet, cal.getTime());

        Map<String, Object> data = new HashMap<>(2);
        data.put("subject", collect2);
        data.put("amount", aggregateAmount);

        return JsonResult.successful(data);
    }

    private void recursiveParent(List<SubjectVo> subjects, Integer parentId) {
        QueryWrapper qw = Wrappers.query();
        this.setQwAccountSetsId(qw);
        qw.eq("id", parentId);
        Subject parent = this.service.getOne(qw);
        SubjectVo vo = new SubjectVo();
        BeanUtils.copyProperties(parent, vo);
        subjects.add(vo);
        if (parent.getLevel() != 1) {
            this.recursiveParent(subjects, parent.getParentId());
        }
    }

    private void recursiveChildren(Map<Integer, SubjectVo> subjectMap, Subject subject, Integer parentId) {
        Subject parent = subjectMap.get(parentId);
        if (parent != null) {
            subject.setName(parent.getName() + "-" + subject.getName());
            if (parent.getLevel() != 1) {
                recursiveChildren(subjectMap, subject, parent.getParentId());
            }
        }
    }

    /**
     * 使用状态检查
     *
     * @param id
     * @return
     */
    @GetMapping("checkUse/{id}")
    public JsonResult checkUse(@PathVariable Integer id) {
        Boolean used = service.checkUse(id);
        return JsonResult.successful(used);
    }

    /**
     * 科目余额
     *
     * @param subjectId
     * @return
     */
    @GetMapping("balance")
    public JsonResult balance(Integer subjectId, Integer categoryId, Integer categoryDetailsId) {
        Double balance = service.balance(this.accountSetsId.get(), subjectId, categoryId, categoryDetailsId, this.currentUser.get().getOrgId());
        return JsonResult.successful(balance);
    }

    /**
     * 导入
     *
     * @param multipartFile
     * @return
     */
    @PostMapping("/import")
    public JsonResult importVoucher(@RequestParam("file") MultipartFile multipartFile) {
        try {
            List<SubjectVo> voucherList = excelUtils.readExcel(multipartFile.getOriginalFilename(), multipartFile.getInputStream(), this.currentUser.get());
            this.service.importVoucher(voucherList, this.currentUser.get().getAccountSets());
            return JsonResult.successful();
        } catch (ServiceException e) {
            return JsonResult.failure(e.getMessage());
        } catch (Exception e) {
            log.error("导入失败", e);
            throw new ServiceException("导入失败~", e);
        }
    }

    @GetMapping("download")
    public void downloadData(HttpServletResponse response) throws IOException {
        String[] columns = ("科目编码,科目名称,类别,余额方向,数量核算,辅助核算").split(",");
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("科目信息");// 工作表对象
        HSSFRow row = sheet.createRow(0);
        for (int i = 0; i < columns.length; i++) {
            HSSFCell codeCell = row.createCell(i);
            codeCell.setCellValue(columns[i]);
            codeCell.setCellType(CellType.STRING);
        }

        LambdaQueryWrapper<Subject> qwd = Wrappers.lambdaQuery();
        qwd.eq(Subject::getAccountSetsId, this.accountSetsId.get());
        qwd.orderByAsc(Subject::getCode);
        // 明细数据
        List<Subject> details = service.list(qwd);

        for (int i = 0; i < details.size(); i++) {
            Subject d = details.get(i);
            HSSFRow dtRow = sheet.createRow(i + 1);
            dtRow.createCell(0).setCellValue(d.getCode());
            dtRow.createCell(1).setCellValue(d.getName());
            dtRow.createCell(2).setCellValue(d.getType().toString());
            dtRow.createCell(3).setCellValue(d.getBalanceDirection().toString());
            dtRow.createCell(4).setCellValue(d.getUnit());
            if (StringUtils.isNotEmpty(d.getAuxiliaryAccounting())) {
                JSONArray auxiliaryAccounting = JSON.parseArray(d.getAuxiliaryAccounting());
                Set<String> auxiliary = new LinkedHashSet<>();
                for (int j = 0; j < auxiliaryAccounting.size(); j++) {
                    auxiliary.add(JSON.parseObject(auxiliaryAccounting.get(j) + "").getString("name"));
                }
                if (auxiliary.size() > 0) {
                    dtRow.createCell(5).setCellValue(auxiliary.stream().collect(Collectors.joining("/")));
                }
            }
        }

        String fileName = "科目信息.xls";
        response.setContentType("application/vnd.ms-excel;");
        response.setHeader("Content-disposition", "attachment; filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
        workbook.write(response.getOutputStream());
        workbook.close();
    }
}
