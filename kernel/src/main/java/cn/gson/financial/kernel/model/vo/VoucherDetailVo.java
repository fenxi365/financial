package cn.gson.financial.kernel.model.vo;

import lombok.Data;

import java.util.Date;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : 凭证科目明细</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月25日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
public class VoucherDetailVo {

    private Date voucherDate;
    private Integer voucherId;
    private Integer detailsId;
    private String word;
    private Integer code;
    private String summary;
    private String subjectName;
    private Integer subjectId;
    private String subjectCode;
    private Double debitAmount;
    private Double creditAmount;
    private String balanceDirection;
    private Double balance;
    private Double num;
    private Double numBalance;
    private Double price;

    public boolean isNull() {
        return this.debitAmount == null && this.creditAmount == null;
    }
}
