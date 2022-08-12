package cn.gson.financial.kernel.model.vo;

import cn.gson.financial.kernel.common.DoubleValueUtil;
import lombok.Data;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : 科目余额</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月03日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
public class BalanceVo {
    /**
     * 科目 id
     */
    private Integer subjectId;

    /**
     * 辅助项目 id
     */
    private Integer auxiliaryId;
    /**
     * 父 id
     */
    private Integer parentId;
    /**
     * 科目名称
     */
    private String name;
    /**
     * 科目编码
     */
    private String code;

    private String unit;
    /**
     * 余额方向
     */
    private String balanceDirection;
    /**
     * 层级
     */
    private Short level;
    /**
     * 期初借方余额
     */
    private Double beginningDebitBalance;
    /**
     * 期初贷方余额
     */
    private Double beginningCreditBalance;
    /**
     * 本期借方发生额
     */
    private Double currentDebitAmount;

    /**
     * 本期借方发数量
     */
    private Double currentDebitAmountNum;
    /**
     * 本期贷方发生额
     */
    private Double currentCreditAmount;
    /**
     * 本期贷方发生数量
     */
    private Double currentCreditAmountNum;
    /**
     * 期末借方余额
     */
    private Double endingDebitBalance;
    /**
     * 期末借方数量余额
     */
    private Double endingDebitBalanceNum;
    /**
     * 期末贷方余额
     */
    private Double endingCreditBalance;
    /**
     * 期末贷方数量余额
     */
    private Double endingCreditBalanceNum;

    public void setBeginningDebitBalance(Double beginningDebitBalance) {
        if (beginningDebitBalance == null) return;

        if (this.beginningDebitBalance == null) {
            this.beginningDebitBalance = beginningDebitBalance;
        } else {
            this.beginningDebitBalance += beginningDebitBalance;
        }
    }

    public void setBeginningCreditBalance(Double beginningCreditBalance) {
        if (beginningCreditBalance == null) return;

        if (this.beginningCreditBalance == null) {
            this.beginningCreditBalance = beginningCreditBalance;
        } else {
            this.beginningCreditBalance += beginningCreditBalance;
        }
    }

    public void setCurrentDebitAmount(Double currentDebitAmount) {
        if (currentDebitAmount == null) return;

        if (this.currentDebitAmount == null) {
            this.currentDebitAmount = currentDebitAmount;
        } else {
            this.currentDebitAmount += currentDebitAmount;
        }
    }

    public void setCurrentDebitAmountNum(Double currentDebitAmountNum) {
        if (currentDebitAmountNum == null) return;

        if (this.currentDebitAmountNum == null) {
            this.currentDebitAmountNum = currentDebitAmountNum;
        } else {
            this.currentDebitAmountNum += currentDebitAmountNum;
        }
    }

    public void setCurrentCreditAmount(Double currentCreditAmount) {
        if (currentCreditAmount == null) return;

        if (this.currentCreditAmount == null) {
            this.currentCreditAmount = currentCreditAmount;
        } else {
            this.currentCreditAmount += currentCreditAmount;
        }
    }

    public void setCurrentCreditAmountNum(Double currentCreditAmountNum) {
        if (currentCreditAmountNum == null) return;

        if (this.currentCreditAmountNum == null) {
            this.currentCreditAmountNum = currentCreditAmountNum;
        } else {
            this.currentCreditAmountNum += currentCreditAmountNum;
        }
    }

    public void setEndingDebitBalance(Double endingDebitBalance) {
        if (endingDebitBalance == null) return;

        if (this.endingDebitBalance == null) {
            this.endingDebitBalance = endingDebitBalance;
        } else {
            this.endingDebitBalance += endingDebitBalance;
        }
    }

    public void setEndingDebitBalanceNum(Double endingDebitBalanceNum) {
        if (endingDebitBalanceNum == null) return;

        if (this.endingDebitBalanceNum == null) {
            this.endingDebitBalanceNum = endingDebitBalanceNum;
        } else {
            this.endingDebitBalanceNum += endingDebitBalanceNum;
        }
    }

    public void setEndingCreditBalance(Double endingCreditBalance) {
        if (endingCreditBalance == null) return;

        if (this.endingCreditBalance == null) {
            this.endingCreditBalance = endingCreditBalance;
        } else {
            this.endingCreditBalance += endingCreditBalance;
        }
    }

    public void setEndingCreditBalanceNum(Double endingCreditBalanceNum) {
        if (endingCreditBalanceNum == null) return;

        if (this.endingCreditBalanceNum == null) {
            this.endingCreditBalanceNum = endingCreditBalanceNum;
        } else {
            this.endingCreditBalanceNum += endingCreditBalanceNum;
        }
    }

    public void setBeginningBalance(Double beginBalance) {
        switch (this.balanceDirection) {
            case "借":
                this.setBeginningDebitBalance(beginBalance);
                break;
            case "贷":
                this.setBeginningCreditBalance(beginBalance);
                break;
        }
    }

    public void setBeginningActiveBalance(double beginBalance) {
        if (beginBalance > 0) {
            switch (this.balanceDirection) {
                case "借":
                    this.setBeginningDebitBalance(beginBalance);
                    break;
                case "贷":
                    this.setBeginningCreditBalance(beginBalance);
                    break;
            }
        } else if (beginBalance < 0) {
            switch (this.balanceDirection) {
                case "借":
                    this.setBeginningCreditBalance(Math.abs(beginBalance));
                    break;
                case "贷":
                    this.setBeginningDebitBalance(Math.abs(beginBalance));
                    break;
            }
        }
    }

    public void setEndingActiveBalance(double endBalance) {
        if (endBalance > 0) {
            switch (this.balanceDirection) {
                case "借":
                    this.setEndingDebitBalance(endBalance);
                    break;
                case "贷":
                    this.setEndingCreditBalance(endBalance);
                    break;
            }
        } else if (endBalance < 0) {
            switch (this.balanceDirection) {
                case "借":
                    this.setEndingCreditBalance(Math.abs(endBalance));
                    break;
                case "贷":
                    this.setEndingDebitBalance(Math.abs(endBalance));
                    break;
            }
        }
    }

    public Double getBeginningBalance() {
        if (this.balanceDirection == null || (this.beginningCreditBalance == null && this.beginningDebitBalance == null)) {
            return null;
        }
        double val;
        if ("借".equals(this.balanceDirection)) {
            if (this.beginningDebitBalance != null) {
                val = this.beginningDebitBalance;
            } else {
                val = 0 - this.beginningCreditBalance;
            }
        } else {
            if (this.beginningDebitBalance != null) {
                val = 0 - this.beginningDebitBalance;
            } else {
                val = this.beginningCreditBalance;
            }
        }
        return val;
    }

    public Double getEndingBalance() {
        return DoubleValueUtil.getNotNullVal(this.endingDebitBalance, this.endingCreditBalance);
    }
}
