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
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

        Map<String, VoucherDetails> aggregateAmount = voucherDetailsService.getAggregateAmount(this.accountSetsId, codeSet, cal.getTime());

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
        Double balance = service.balance(this.accountSetsId, subjectId, categoryId, categoryDetailsId);
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
            List<SubjectVo> voucherList = excelUtils.readExcel(multipartFile.getOriginalFilename(), multipartFile.getInputStream(), this.currentUser);
            this.service.importVoucher(voucherList, this.currentUser.getAccountSets());
            return JsonResult.successful();
        } catch (ServiceException e) {
            return JsonResult.failure(e.getMessage());
        } catch (Exception e) {
            log.error("导入失败", e);
            throw new ServiceException("导入失败~", e);
        }
    }
}
