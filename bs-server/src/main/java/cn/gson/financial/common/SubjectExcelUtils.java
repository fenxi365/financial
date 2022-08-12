package cn.gson.financial.common;

import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.AccountingCategory;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.vo.SubjectVo;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.service.AccountingCategoryService;
import cn.gson.financial.kernel.service.SubjectService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.common</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年10月18日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@Component
public final class SubjectExcelUtils {
    private final String[] COLS = {"科目编码", "科目名称", "类别", "余额方向", "数量核算", "辅助核算", "外币核算", "期末调汇"};

    @Autowired
    private SubjectService subjectService;

    @Autowired
    private AccountingCategoryService categoryService;

    private List<Integer> encoding;

    /**
     * 读取excel数据并转化
     *
     * @param fileName
     * @param is
     * @param userVo
     * @return
     * @throws IOException
     */
    public List<SubjectVo> readExcel(String fileName, InputStream is, UserVo userVo) throws IOException {
        encoding = Arrays.stream(userVo.getAccountSets().getEncoding().split("-")).map(s -> Integer.parseInt(s)).collect(Collectors.toList());
        List<SubjectVo> list = new ArrayList<>();
        Map<String, SubjectVo> subjectMap = new HashMap<>();

        Workbook workbook;
        if ("xls".equals(FilenameUtils.getExtension(fileName))) {
            workbook = new HSSFWorkbook(is);
        } else {
            workbook = new XSSFWorkbook(is);
        }
        Sheet sheet = workbook.getSheetAt(0);
        if (sheet != null) {
            //检查excel格式
            this.checkHeader(sheet);
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                SubjectVo subject = new SubjectVo();
                subject.setLevel((short) 0);
                subject.setChildren(new ArrayList<>());
                subject.setType(row.getCell(2).getStringCellValue().replace("类", ""));
                if (row.getCell(0).getCellType().equals(CellType.NUMERIC)) {
                    Double value = row.getCell(0).getNumericCellValue();
                    subject.setCode(value.intValue() + "");
                } else {
                    subject.setCode(StringUtils.trim(row.getCell(0).getStringCellValue()));
                }
                subject.setName(StringUtils.trim(row.getCell(1).getStringCellValue()));
                subject.setBalanceDirection(StringUtils.trim(row.getCell(3).getStringCellValue()));
                subject.setStatus(true);
                subject.setAccountSetsId(userVo.getAccountSetsId());
                subject.setUnit(StringUtils.trim(row.getCell(4).getStringCellValue()));
                subject.setAuxiliaryAccounting(this.getCategory(userVo.getAccountSetsId(), row.getCell(5).getStringCellValue()));
                subject.setMnemonicCode(PinYinUtil.getFirstLettersLo(subject.getName()));

                if (userVo.getAccountSets().getAccountingStandards() == (short) 0 && subject.getType().equals("共同")) {
                    throw new ServiceException("当前企业会计准则为[小企业会计准则],不允许导入[企业会计准则]科目！");
                }

                if (!"借".equals(subject.getBalanceDirection()) && !"贷".equals(subject.getBalanceDirection())) {
                    throw new ServiceException("编码[" + subject.getCode() + "]的余额方向错误。正确值为：借、贷");
                }

                String code = subject.getCode();
                //编码格式检查
                this.checkCode(code);
                //顶级科目和子集科目分开存储
                int len = subject.getCode().length();

                if (len == getLen(1)) {
                    subject.setLevel((short) 1);
                } else if (len == getLen(2)) {
                    subject.setLevel((short) 2);
                    subject.setParentCode(code.substring(0, getLen(1)));
                } else if (len == getLen(3)) {
                    subject.setLevel((short) 3);
                    subject.setParentCode(code.substring(0, getLen(2)));
                } else if (len == getLen(4)) {
                    subject.setLevel((short) 4);
                    subject.setParentCode(code.substring(0, getLen(3)));
                }
                list.add(subject);
                subjectMap.put(code, subject);
            }

            Map<String, Subject> orgSubject = getByCodeList(userVo.getAccountSetsId(), subjectMap.keySet());

            //构建树形数据
            for (SubjectVo vo : list) {
                //如果编码已经存在，这设置初始属性
                if (orgSubject.containsKey(vo.getCode())) {
                    Subject subject = orgSubject.get(vo.getCode());
                    vo.setId(subject.getId());
                    vo.setSystemDefault(subject.getSystemDefault());
                    vo.setStatus(subject.getStatus());
                    vo.setParentId(subject.getParentId());
                }

                //上级判断
                if (StringUtils.isNotEmpty(vo.getParentCode())) {
                    SubjectVo parent = subjectMap.get(vo.getParentCode());
                    vo.setMnemonicCode(parent.getMnemonicCode() + "_" + PinYinUtil.getFirstLettersLo(vo.getName()));
                    if (parent != null) {
                        parent.getChildren().add(vo);
                    }
                }
            }
        }

        List<SubjectVo> subjectVos = list.stream().filter(subjectVo -> new Short("1").equals(subjectVo.getLevel())).collect(Collectors.toList());

        log.info("subjectVos:{}", JSONObject.toJSONString(subjectVos));

        return subjectVos;
    }

    /**
     * 获取长度
     *
     * @param lv
     * @return
     */
    private int getLen(int lv) {
        int len = 0;
        for (int i = 0; i < lv; i++) {
            len += encoding.get(i);
        }
        return len;
    }

    /**
     * 编码格式检查
     *
     * @param code
     */
    private void checkCode(@NonNull String code) {
        String reg = "\\d{4}(\\d{" + encoding.get(1) + "})?(\\d{" + encoding.get(2) + "})?(\\d{" + encoding.get(3) + "})?";
        if (!code.matches(reg)) {
            throw new ServiceException("编码：" + code + ",不符合格式：" + StringUtils.join(encoding, "-"));
        }
    }

    private Map<String, Subject> getByCodeList(Integer accountSetsId, Set<String> subjectCodeSet) {
        LambdaQueryWrapper<Subject> qw = Wrappers.lambdaQuery();
        qw.eq(Subject::getAccountSetsId, accountSetsId);
        qw.in(Subject::getCode, subjectCodeSet);

        List<Subject> list = this.subjectService.list(qw);
        return list.stream().collect(Collectors.toMap(Subject::getCode, subject -> subject));
    }

    private String getCategory(Integer accountSetsId, String ca) {
        if (StringUtils.isEmpty(ca)) {
            return null;
        }

        QueryWrapper<AccountingCategory> qw = Wrappers.query();
        qw.eq(AccountingCategory.COL_ACCOUNT_SETS_ID, accountSetsId);
        qw.in(AccountingCategory.COL_NAME, Arrays.asList(StringUtils.split(ca, "/")));
        List<AccountingCategory> list = categoryService.list(qw);
        if (list.isEmpty()) {
            throw new ServiceException("辅助项：[" + ca + "]在账套中不存在！");
        }
        List<Map<String, Object>> collect = list.stream().map(sss -> {
            Map<String, Object> item = new HashMap<>();
            item.put("id", sss.getId());
            item.put("name", sss.getName());
            return item;
        }).collect(Collectors.toList());
        return JSON.toJSONString(collect);
    }

    /**
     * 表头检查，不符合表头，不允许导入
     *
     * @param sheet
     */
    private void checkHeader(Sheet sheet) {
        Row row = sheet.getRow(0);
        for (int i = 0; i < COLS.length; i++) {
            String col = COLS[i];
            Cell cell = row.getCell(i);
            if (!col.equalsIgnoreCase(cell.getStringCellValue())) {
                throw new ServiceException("表头错误！表头正确顺序:%s", StringUtils.join(COLS, ","));
            }
        }
    }
}
