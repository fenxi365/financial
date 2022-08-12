<template>
  <div class="voucher-table bg-white-color">
    <table class="header" cellspacing="0" cellpadding="0">
      <tbody>
      <tr class="bg-white-color">
        <td style="width: 208px; font-weight: bold;">摘要</td>
        <td style="width: 308px; font-weight: bold;">会计科目</td>
        <td>
          <div style="font-weight: bold;">
            借方金额
          </div>
          <div class="moneyUint">
            <span>亿</span> <span>千</span> <span>百</span> <span>十</span> <span>万</span> <span>千</span>
            <span>百</span> <span>十</span> <span>元</span> <span>角</span> <span class="last">分</span>
          </div>
        </td>
        <td class="tdLast">
          <div style="font-weight: bold;">
            贷方金额
          </div>
          <div class="moneyUint">
            <span>亿</span> <span>千</span> <span>百</span> <span>十</span> <span>万</span> <span>千</span>
            <span>百</span> <span>十</span> <span>元</span> <span>角</span> <span class="last">分</span>
          </div>
        </td>
      </tr>
      </tbody>
    </table>
    <table class="body" cellspacing="0" cellpadding="0">
      <tbody>
      <tr class="trDetails" v-for="(d,i) in details" :key="i" :data-idx="i">
        <td class="tdZhaoyao tdInput">
          <div class="display" v-if="!d.zyEdit" @click="doEdit(d,'zy',i)">{{ d.data.summary }}</div>
          <DropdownCustom v-show="d.zyEdit" ref="zyDropdown" trigger="manual" :toggle-icon="false" style="width: 100%"
                          equalWidth @hide="endEdit(d,'zy',i)">
            <textarea class="h-input edit" data-type="zy" :data-index="i" :id="'zy'+i" @input="zyInput"></textarea>
            <template slot="content">
              <div style="min-height: 180px;overflow-y: hidden;">
                <ul class="summary" :id="`summary${i}`">
                  <li class="summary-item" :data-index="idx" :class="{'summary-item-select':(idx===0&&zyFiler)}"
                      v-for="(s,idx) in summaryData" @click="chooseSummary(d,s.name,i)">
                    {{ s.name }}
                  </li>
                </ul>
              </div>
            </template>
          </DropdownCustom>
        </td>
        <td class="tdKemu tdInput">
          <div class="display" v-if="!d.kmEdit" @click="doEdit(d,'km',i)">
            {{ d.data.subjectName || '' }}{{ d.data.auxiliaryTitle || '' }}
          </div>
          <div class="yue" v-if="balanceList[d.data.subjectId]">余额：
            <span :class="{'red-color':balanceList[d.data.subjectId]<0}">{{
                balanceList[d.data.subjectId] | numFormat
              }}</span>
          </div>
          <Row v-if="d.data.unit || d.data.num" @click.stop="" class="num" type="flex" :space-x="10">
            <Cell>数量:</Cell>
            <Cell>
              <span @click.stop="showInput" class="text-hover">{{ d.data.num || 0 }}</span>
              <input class="numInput" @blur.stop="hideInput($event,d.data)" @click="" style="display: none;"
                     v-model="d.data.num" @click.stop="" v-width="40">
            </Cell>
            <Cell>单价:</Cell>
            <Cell>
              <span @click.stop="showInput" class="text-hover">{{ d.data.price || 0 }}</span>
              <input class="numInput" @blur.stop="hideInput($event,d.data)" style="display: none;"
                     v-model="d.data.price" @click.stop="" v-width="40">
            </Cell>
          </Row>
          <DropdownCustom v-show="d.kmEdit" ref="kmDropdown" trigger="manual" :toggle-icon="false" style="width: 100%"
                          equalWidth @hide="endEdit(d,'km',i)">
            <textarea class="h-input edit" data-type="km" :data-index="i" :id="'km'+i" @input="kmInput"></textarea>
            <template slot="content">
              <div style="height: 180px;overflow-y: scroll;overflow-x:hidden;" v-if="!d.auxiliary">
                <ul class="subjects" :id="`subjects${i}`">
                  <li class="subjects-item" :data-index="idx" :class="{'subjects-item-select':(idx===0&&kmFiler)}"
                      v-for="(s,idx) in subjectData" @click="chooseSubject(d,s,i)">
                    {{ s.code }} {{ s.name }}
                  </li>
                </ul>
              </div>
              <div v-else class="auxiliary padding">
                <Row v-if="auxiliaryAccounting[i]" v-for="item in auxiliaryAccounting[i]" type="flex" :space="10"
                     :key="item.id">
                  <Cell :flex="1" class="label">{{ item.name }}</Cell>
                  <Cell v-width="180">
                    <Select v-model="d.data[item.id]" v-if="auxiliaryAccountingData[d.data.subjectId]" type="object"
                            className="auxiliary" keyName="id" titleName="name"
                            :datas="auxiliaryAccountingData[d.data.subjectId][item.id]" :filterable="true"></Select>
                  </Cell>
                </Row>
                <div class="text-center margin-top">
                  <Button color="primary" @click="fillAuxiliary(d,auxiliaryAccountingData[d.data.subjectId],i)">确认
                  </Button>
                </div>
              </div>
            </template>
          </DropdownCustom>
        </td>
        <td class="tdJieFang tdInput">
          <div v-if="!d.jfEdit" class="display displayMoney" :class="{'red-color':d.data.debitAmount<0}"
               @click="doEdit(d,'jf',i)">
            <span @click.stop="doEdit(d,'jf',i)">{{ d.data.debitAmount|formatMoney }}</span>
          </div>
          <DropdownCustom v-show="d.jfEdit" ref="jfDropdown" placement="top" trigger="manual" :toggle-icon="false"
                          style="width: 100%" equalWidth @hide="endEdit(d,'jf',i)">
            <input max="999999999" min="-999999999" type="number" class="h-input jf edit" data-type="jf" :data-index="i"
                   :id="'jf'+i" v-model="d.data.debitAmount" @keydown="moveCol($event,d,'jf',i)">
            <template slot="content">
              <div class="hoverNum">{{ d.data.debitAmount|numFormat }}</div>
            </template>
          </DropdownCustom>
        </td>
        <td class="tdLast tdDaiFang tdInput">
          <div v-if="!d.dfEdit" class="display displayMoney" :class="{'red-color':d.data.creditAmount<0}"
               @click="doEdit(d,'df',i)">
            <span @click.stop="doEdit(d,'df',i)">{{ d.data.creditAmount|formatMoney }}</span>
          </div>
          <DropdownCustom v-show="d.dfEdit" ref="dfDropdown" placement="top" trigger="manual" :toggle-icon="false"
                          style="width: 100%" equalWidth @hide="endEdit(d,'df',i)">
            <input max="999999999" min="-999999999" :data-index="i" data-type="df" class="h-input df edit" :id="'df'+i"
                   v-model="d.data.creditAmount" step="" @keydown="moveCol($event,d,'df',i)">
            <template slot="content">
              <div class="hoverNum">{{ d.data.creditAmount|numFormat }}</div>
            </template>
          </DropdownCustom>
        </td>
      </tr>
      <tr class="trDetails total">
        <td colspan="2" class="spTotal padding-left">
          合计: {{ jfTotal|dxMoney }}
        </td>
        <td style="width: 220px;">
          <div class="display displayMoney">
            <span class="spTotalDebit">{{ jfTotal|formatMoney }}</span>
          </div>
        </td>
        <td class="tdLast" style="width: 220px;">
          <div class="display displayMoney">
            <span class="spTotalCredit">{{ dfTotal|formatMoney }}</span>
          </div>
        </td>
      </tr>
      </tbody>
    </table>
    <i class="action fa fa-times-circle" @click="removeItem()"></i>
    <i class="action fa fa-plus-circle" @click="addItem()"></i>
  </div>
</template>

<script>
import jQuery from 'jquery';
import Decimal from 'decimal.js';
import Pinyin from 'chinese-to-pinyin';

const detail = {
  zyEdit: false,
  kmEdit: false,
  jfEdit: false,
  dfEdit: false,
  auxiliary: false,
  data: {summary: '', subjectName: ''}
};

const nextTag = {
  zy: 'km',
  km: 'jf',
  jf: 'df'
};

const FormatNum = function (num, digit = 2) {
  return Decimal(num).toFixed(digit);
};

const ToPy = (name) => {
  let pyArr = [];
  name.split("").forEach(w => {
    w = w.trim();
    if (w) {
      if (/[\u4e00-\u9fa5]/.test(w)) {
        let py = Pinyin(w, {removeTone: true, keepRest: true}).trim();
        pyArr.push(py.substring(0, 1));
      } else {
        pyArr.push(w);
      }
    }
  });

  return pyArr.join("");
};

export default {
  name: "VoucherTable",
  props: {
    value: Object,
  },
  data() {
    return {
      details: [{
        zyEdit: false,
        kmEdit: false,
        jfEdit: false,
        dfEdit: false,
        auxiliary: false,
        data: {summary: ''}
      }, {
        zyEdit: false,
        kmEdit: false,
        jfEdit: false,
        dfEdit: false,
        auxiliary: false,
        data: {summary: ''}
      }, {
        zyEdit: false,
        kmEdit: false,
        jfEdit: false,
        dfEdit: false,
        auxiliary: false,
        data: {summary: ''}
      }, {zyEdit: false, kmEdit: false, jfEdit: false, dfEdit: false, auxiliary: false, data: {summary: ''}}],
      hoverIdx: -1,
      voucherSelect: [],
      summarySelect: [],
      auxiliaryAccounting: [],
      zyFiler: "",
      kmFiler: "",
      zaiYao: [],
      balanceList: {},
      initBalanceList: {},
      auxiliaryAccountingData: {},
      currentEdit: null,
      jfTotal: 0,
      dfTotal: 0
    }
  },
  computed: {
    subjectData() {
      if (this.kmFiler) {
        return this.voucherSelect.filter(value => {
          return value.code.indexOf(this.kmFiler) !== -1 || value.name.indexOf(this.kmFiler) !== -1 || value.mnemonicCode.indexOf(this.kmFiler) !== -1;
        });
      }
      return this.voucherSelect;
    },
    summaryData() {
      if (this.zyFiler) {
        return this.summarySelect.filter(value => {
          return value.name.indexOf(this.zyFiler) !== -1 || value.mnemonicCode.indexOf(this.zyFiler) !== -1;
        });
      }
      return this.summarySelect;
    },
    voucherItems() {
      return this.details.map(value => value.data).filter(value => {
        return value.subjectId || value.summary || value.debitAmount || value.creditAmount;
      }).map(value => {
        let keys = Object.keys(value).filter(key => !isNaN(Number(key))), auxiliary = [];
        if (keys.length) {
          keys.forEach(key => {
            auxiliary.push(value[key]);
          })
        }

        return {
          auxiliary,
          debitAmount: value.debitAmount,
          creditAmount: value.creditAmount,
          subjectId: value.subjectId,
          direction: value.direction,
          subjectName: value.subjectName || '',
          subjectCode: value.subjectCode || '',
          auxiliaryTitle: value.auxiliaryTitle || '',
          summary: value.summary ? value.summary.trim().replace(/\s+/g, '') : '',
          num: value.num,
          price: value.price
        }
      });
    }
  },
  methods: {
    kmInput(e) {
      this.kmFiler = e.target.value;
      this.$set(this.details[this.currentEdit.idx], 'auxiliary', false);
    },
    zyInput(e) {
      this.zyFiler = e.target.value;
      this.$set(this.details[this.currentEdit.idx].data, 'summary', e.target.value);
    },
    removeItem() {
      if (this.details.length > 4) {
        this.details.splice(this.hoverIdx, 1);
      } else {
        this.$set(this.details[this.hoverIdx], 'data', {});
      }
    },
    addItem(idx) {
      this.details.splice(idx ? idx : Math.max((this.hoverIdx), 0), 0, {
        zyEdit: false,
        kmEdit: false,
        jfEdit: false,
        dfEdit: false,
        auxiliary: false,
        data: {summary: '', subjectName: ''}
      });
      this.$nextTick(() => {
        this.bindEnterTabKeydownEvt();
      })
    },
    doEdit(row, type, idx) {
      if (this.currentEdit) {
        this.endEdit(this.currentEdit.row, this.currentEdit.type, this.currentEdit.idx)
      }
      this.$nextTick(() => {
        this.$set(row, type + 'Edit', true);
        this.currentEdit = {row, type, idx};

        this.$nextTick(() => {
          let keMuTxt = jQuery(`textarea#${type}${idx}`);
          keMuTxt.focus().select();
          if (type === 'km') {
            keMuTxt.val(row.data.subjectName);
            if (row.data.subject && row.data.subject.auxiliaryAccounting) {
              this.$set(this.details[idx], 'auxiliary', true);
            }
          }
          jQuery(".h-input", `#${type}${idx}`).focus().select();
          jQuery(`#${type}${idx}`).focus().select();
          this.$refs[`${type}Dropdown`][idx].show();
        });
      });
    },
    moveCol(e, row, type, tidx) {
      let debitAmount = Number(row.data.debitAmount); //借方
      let creditAmount = Number(row.data.creditAmount); //贷方
      switch (e.keyCode) {
        case 32:
          if (!isNaN(creditAmount) && !isNaN(creditAmount) && creditAmount) {
            this.currentEdit.type= 'jf';
            this.doEdit(row,'jf',tidx);
            setTimeout(() => {
              this.$nextTick(() => {
                this.$set(row, 'jfEdit', true);
                this.$set(row, 'dfEdit', false);
                this.$set(this.currentEdit.row, 'creditAmount', '');
                this.$set(this.currentEdit.row, 'debitAmount', creditAmount);
                this.$set(row.data, 'creditAmount', '');
                this.$set(row.data, 'debitAmount', creditAmount);
              });
            }, 90);
          } else if (!isNaN(debitAmount) && !isNaN(debitAmount) && debitAmount) {
            this.currentEdit.type= 'df';
            this.doEdit(row,'df',tidx);
            setTimeout(() => {
              this.$nextTick(() => {
                this.$set(row, 'jfEdit', false);
                this.$set(row, 'dfEdit', true);
                this.$set(this.currentEdit.row, 'debitAmount', '');
                this.$set(this.currentEdit.row, 'creditAmount', debitAmount);
                this.$set(row.data, 'debitAmount', '');
                this.$set(row.data, 'creditAmount', debitAmount);
              });
            }, 90);
          }
      }
    },
    endEdit(row, type, idx, doNext = false) {
      if (row[type + 'Edit']) {
        this.$set(row, type + 'Edit', false);
        this.kmFiler = "";
        let debitAmount = Number(row.data.debitAmount);
        let creditAmount = Number(row.data.creditAmount);
        switch (type) {
          case 'jf':
            if (!isNaN(debitAmount) && !isNaN(creditAmount) && debitAmount) {
              this.$set(row.data, 'creditAmount', '');
            }
            this.calculateBalance(row.data.subjectId);
            break;
          case 'df':
            if (!isNaN(debitAmount) && !isNaN(creditAmount) && creditAmount) {
              this.$set(row.data, 'debitAmount', '');
            }
            break;
        }

        this.calculateBalance(row.data.subjectId);

        //如果有单位则需要计算单价
        if (row.data.unit && row.data.num > 0) {
          let money = debitAmount || creditAmount;
          this.$set(this.details[idx].data, 'price', Number((money / row.data.num).toFixed(2)));
        }

        let dropdown = this.$refs[`${type}Dropdown`][idx];
        dropdown && dropdown.hide();
        //关闭辅助项输入
        this.$set(this.details[idx], 'auxiliary', false);

        if (doNext) {
          if (type === 'jf' && row.data.debitAmount) {
            this.lastNext(idx);
          } else if (type !== 'df') {
            this.doEdit(row, nextTag[type], idx);
          } else {
            this.lastNext(idx);
          }
        }
      }
    },
    lastNext(idx) {
      let row = this.details[idx + 1];
      if (!row) {
        this.addItem(idx + 1);
      }
      this.uponSummary(idx);
    },
    uponSummary(idx) {
      let row = this.details[idx].data;
      if (row && row.summary) {
        let data = this.details[idx + 1].data;
        this.$set(data, 'summary', row.summary);
        this.doEdit(this.details[idx + 1], 'zy', idx + 1);
        jQuery(`textarea#zy${idx + 1}`).val(row.summary);
      } else {
        this.doEdit(this.details[idx + 1], 'zy', idx + 1);
      }
    },
    calculateBalance(subjectId) {
      if (subjectId) {
        let balance = this.initBalanceList[subjectId] || 0;
        let items = this.voucherItems.filter(val => val.subjectId === subjectId);
        items.forEach(val => {
          if (val.direction === "借") {
            if (val.debitAmount) {
              balance += Number(val.debitAmount);
            } else if (val.creditAmount) {
              balance -= Number(val.creditAmount);
            }
          } else {
            if (val.debitAmount) {
              balance -= Number(val.debitAmount);
            } else if (val.creditAmount) {
              balance += Number(val.creditAmount);
            }
          }
        });
        this.$set(this.balanceList, subjectId, FormatNum(balance));
      }
    },
    loadVoucherSelect() {
      let tmp = localStorage.getItem('voucherSelect');
      let tmp2 = localStorage.getItem('summarySelect');
      if (tmp) {
        this.voucherSelect = JSON.parse(tmp);
      }
      if (tmp2) {
        this.summarySelect = JSON.parse(tmp2);
      }

      this.$api.setting.subject.voucherSelect().then(({data}) => {
        this.voucherSelect = data;
        localStorage.setItem("voucherSelect", JSON.stringify(data));
      });

      this.$api.voucher.summary().then(({data}) => {
        let newData = data.map(val => {
          return {
            name: val,
            mnemonicCode: ToPy(val)
          }
        });
        this.summarySelect = newData;
        localStorage.setItem("summarySelect", JSON.stringify(newData));
      });
    },
    chooseSummary(d, summary, idx) {
      this.$set(d.data, 'summary', summary);
      jQuery(`textarea#zy${idx}`).val(this.currentEdit.row.data.summary);
      this.$refs.zyDropdown[idx].hide();
    },
    chooseSubject(d, subject, idx) {
      if (d.data.subjectId !== subject.id) {
        this.$set(d, 'data', {
          'subjectName': subject.code + "-" + subject.name,
          'subjectId': subject.id,
          'subjectCode': subject.code,
          'unit': subject.unit,
          'direction': subject.balanceDirection,
          'summary': d.data.summary,
          'creditAmount': d.data.creditAmount,
          'debitAmount': d.data.debitAmount,
          'subject': subject
        });
        this.loadSubjectBalance(d.data, subject.id);
      }
      //判断是否有辅助项目
      if (subject.auxiliaryAccounting) {
        this.auxiliaryAccounting[idx] = JSON.parse(subject.auxiliaryAccounting);
        this.loadAuxiliaryAccountingData(idx, subject);
        //开启辅助项输入
        this.$nextTick(() => {
          this.$set(this.details[idx], 'auxiliary', true);
          this.$set(this.currentEdit, 'auxiliary', true);
        });
        jQuery(`textarea#km${idx}`).val(this.currentEdit.row.data.subjectName);
      } else {
        this.endEdit(d, 'km', idx, true);
      }
    },
    loadSubjectBalance(d, subjectId) {
      if (!this.balanceList[subjectId]) {
        this.$api.setting.subject.balance({subjectId: subjectId}).then(({data}) => {
          this.balanceList[subjectId] = data;
          this.initBalanceList[subjectId] = data;
          this.$set(d, 'balance', data);
        })
      } else {
        this.$set(d, 'balance', this.balanceList[subjectId]);
      }
    },
    clear() {
      this.details = initDetails();
    },
    loadAuxiliaryAccountingData(idx, subject) {
      if (!this.auxiliaryAccountingData[subject.id]) {
        this.$api.setting.accountingCategoryDetails.loadAuxiliaryAccountingData(this.auxiliaryAccounting[idx]).then(({data}) => {
          this.$set(this.auxiliaryAccountingData, subject.id, data);
        });
      }
    },
    fillAuxiliary(row, auxiliaryData, idx) {
      let title = "", rowData = row.data;
      Object.keys(auxiliaryData).forEach(val => {
        if (rowData[val]) {
          title += '_' + rowData[val].code + "_" + rowData[val].name;
        }
      });
      this.endEdit(row, 'km', idx, true);
      this.$nextTick(() => {
        this.$set(rowData, "auxiliaryTitle", title);
      });
    },
    showInput(e) {
      let target = jQuery(e.target);
      target.hide();
      target.next().show().focus().select();
    },
    hideInput(e, row) {
      let target = jQuery(e.target);
      target.hide();
      target.prev().show();
      let inputs = target.closest('.num').find('.numInput');
      switch (row.direction) {
        case '借':
          this.$set(row, "debitAmount", FormatNum(Number(inputs[0].value) * Number(inputs[1].value)));
          this.$set(row, "creditAmount", "");
          break;
        case '贷':
          this.$set(row, "creditAmount", FormatNum(Number(inputs[0].value) * Number(inputs[1].value)));
          this.$set(row, "debitAmount", "");
          break;
      }
    },
    initValue(voucherItems) {
      this.details = [{
        zyEdit: false,
        kmEdit: false,
        jfEdit: false,
        dfEdit: false,
        auxiliary: false,
        data: {summary: ''}
      }, {
        zyEdit: false,
        kmEdit: false,
        jfEdit: false,
        dfEdit: false,
        auxiliary: false,
        data: {summary: ''}
      }, {
        zyEdit: false,
        kmEdit: false,
        jfEdit: false,
        dfEdit: false,
        auxiliary: false,
        data: {summary: ''}
      }, {zyEdit: false, kmEdit: false, jfEdit: false, dfEdit: false, auxiliary: false, data: {summary: ''}}];
      voucherItems.forEach((item, idx) => {
        item.subjectName = item.subjectName;
        item.auxiliaryTitle = item.auxiliaryTitle;

        if (item.subject) {
          item.direction = item.subject.balanceDirection;
          item.unit = item.subject.unit;
          if (item.subject.auxiliaryAccounting) {
            this.auxiliaryAccounting[idx] = JSON.parse(item.subject.auxiliaryAccounting);
            this.loadAuxiliaryAccountingData(idx, item.subject);
          }
        }

        if (item.auxiliary) {
          item.auxiliary.forEach(a => {
            item[a.accountingCategoryId] = a.accountingCategoryDetails;
          });
          delete item.auxiliary;
        }
        this.$set(this.details, idx, Object.assign({}, detail, {data: item}));
      });
    },
    bindEnterTabKeydownEvt() {
      let that = this;
      jQuery(".trDetails").off("keyup", ".edit");
      jQuery(".trDetails").off("keydown", ".edit");
      jQuery(".trDetails").off("blur", ".jf,.df");

      jQuery(".trDetails").on("blur", ".jf,.df", (e) => {
        let {type, index} = jQuery(e.target).closest('.edit').data();
        this.endEdit(that.details[index], type, index, false);
      });

      jQuery(".trDetails").on("keyup", ".edit", function (e) {
        let {type, index} = jQuery(e.target).closest('.edit').data();
        //贷方等于号输入处理
        if ((e.keyCode === 187 || e.code === "Equal" || e.code === "NumpadEqual" || e.key === "=") && (type === 'jf' || type === 'df')) {
          e.preventDefault();
          let details = Array.from(that.details);
          let totalCredit = 0, totalDebit = 0;
          details.forEach((value, i) => {
            if (index !== i) {
              let creditAmount = Number(value.data.creditAmount), debitAmount = Number(value.data.debitAmount);
              if (!isNaN(creditAmount)) {
                totalCredit += creditAmount;
              }
              if (!isNaN(debitAmount)) {
                totalDebit += debitAmount;
              }
            }
          });

          if (type === 'jf' && totalCredit !== 0) {
            details[index].data.debitAmount = FormatNum(totalCredit - totalDebit);
            details[index].data.creditAmount = 0;
            e.target.value = details[index].data.debitAmount.toFixed(2);
          } else if (type === 'df' && totalDebit !== 0) {
            details[index].data.creditAmount = FormatNum(totalDebit - totalCredit);
            details[index].data.debitAmount = 0;
            e.target.value = details[index].data.creditAmount.toFixed(2);
          }

          that.$set(that, 'details', details);
          return false;
        }
      });

      jQuery(".trDetails").on("keydown", ".edit", function (e) {
        let {type, index} = jQuery(e.target).closest('.edit').data();
        if (e.keyCode === 13 || e.keyCode === 9) {
          e.preventDefault();
          if (type === 'km') {
            jQuery('li.subjects-item-select', `#subjects${index}`).click();
            return;
          }
          if (type === 'zy') {
            let select = jQuery(`.summary-item-select`, `#summary${index}`);
            if (select.length) {
              that.$set(that.details[index].data, 'summary', select.text());
            }
          }
          that.endEdit(that.details[index], type, index, true);
          return false;
        }

        if (e.keyCode === 38 || e.keyCode === 40) {
          e.preventDefault();
          if (type === 'km' || type === 'zy') {
            let idPre = type === 'km' ? "subjects" : "summary";
            let subjects = jQuery(`#${idPre}${index}`);
            let select = jQuery(`.${idPre}-item-select`, subjects);

            if (!select.length) {
              subjects.children().first().addClass(`${idPre}-item-select`);
              return false;
            }

            let next = select.prev('li');
            if (e.keyCode === 40) {
              next = select.next('li');
            }

            if (next.length) {
              next.addClass(`${idPre}-item-select`);
              select.removeClass(`${idPre}-item-select`);
              let i = next.data('index');
              if (i > 7) {
                let top = subjects.parent().scrollTop();
                subjects.parent().scrollTop(top + 22)
              }
            }
          }
          return false;
        }
      });
    },
    calculationOfTotal() {
      let jfTotal = 0, dfTotal = 0;
      this.details.forEach(value => {
        let debit, credit;
        if ((debit = Number(value.data.debitAmount))) {
          jfTotal += debit;
        }
        if ((credit = Number(value.data.creditAmount))) {
          dfTotal += credit;
        }
      });

      this.jfTotal = FormatNum(jfTotal);
      this.dfTotal = FormatNum(dfTotal);
    }
  },
  filters: {
    formatMoney: function (value) {
      if (Number(value)) {
        let sp = (Math.abs(FormatNum(value)) + "").split(".");
        if (!sp[1]) {
          return sp[0] + "00"
        } else if (sp[1].length < 2) {
          return sp[0] + sp[1] + "0"
        }
        return sp[0] + sp[1];
      }
      return '';
    },
    fixNum(value) {
      return Number(value) ? FormatNum(value) : '';
    }
  },
  watch: {
    details: {
      deep: true,
      handler() {
        this.calculationOfTotal();
        this.$emit("input", {
          voucherItems: this.voucherItems,
          jfTotal: this.jfTotal || null,
          dfTotal: this.dfTotal || null
        });
      }
    }
  },
  mounted() {
    let that = this;
    this.$nextTick(() => {
      jQuery('table.body').on("mouseover", 'tr.trDetails:not(.total)', function () {
        that.hoverIdx = jQuery(this).data('idx');
        let offset = jQuery(this).offset();
        let offsetParent = jQuery(this).offsetParent().offset();

        jQuery('i.fa-plus-circle').css({
          left: offset.left - offsetParent.left - 14,
          top: offset.top - offsetParent.top + 25,
          display: 'inline-block'
        }).show();
        jQuery('i.fa-times-circle').css({
          left: offset.left - offsetParent.left + 960,
          top: offset.top - offsetParent.top + 25,
          display: 'inline-block'
        }).show();
      }).on("mouseleave", 'tr.trDetails', function () {
        jQuery("i.action[class!='show']").hide();
      });

      jQuery('i.action').hover(function () {
        jQuery(this).addClass('show').css({display: 'inline-block'});
      }, function () {
        jQuery(this).removeClass('show').hide();
      });

      jQuery("#app").click((e) => {
        if (!jQuery(e.target).hasClass('display')
            && !jQuery(e.target).hasClass('subjects-item')
            && !jQuery(e.target).closest('.auxiliary').length
            && !jQuery(e.target).closest('.tdInput').length
            && !jQuery(e.target).closest('.h-dropdown').length
            && this.currentEdit) {
          this.endEdit(this.currentEdit.row, this.currentEdit.type, this.currentEdit.idx)
        }
      });

      this.bindEnterTabKeydownEvt();
    });

    this.loadVoucherSelect();
  }
}
</script>

<style lang="less">
.voucher-table {
  position: relative;
  font-size: 12px;
  width: 1000px;
  padding: 10px 20px;

  .tdLast {
    border-right: 1px solid #dadada;
  }

  .header {
    width: 960px;
    text-align: center;
    line-height: 30px;
  }

  table tbody tr td {
    border-left: 1px solid #dadada;
    border-top: 1px solid #dadada;
    border-bottom: 1px solid #dadada;
    padding: 0;
    border-spacing: 0;
  }

  .moneyUint {
    border-top: 1px solid #dadada;
    height: 30px;
    background-image: url(../assets/moneyUint.png);
    width: 221px;

    span {
      float: left;
      display: inline;
      width: 19px;
      height: 100%;
      margin-right: 1px;
      background-color: #fff;
      text-align: center;
      font-size: 12px;
    }

    .last {
      margin-right: 0;
    }
  }

  .body {
    width: 960px;
    text-align: center;

    .numInput {
      outline: none;
    }

    td {
      vertical-align: top;
    }

    .trDetails {
      width: 959px;

      .spTotal {
        width: 250px;
        text-align: left;
        vertical-align: middle;
        font-weight: bold;
      }

      .h-icon-error {
        right: 55px;
        top: 20px;
      }

      .display {
        height: 60px;
        font-weight: bold;
        font-size: 13px;
        text-align: left;
        padding: 2px;
        line-height: 17px;
      }

      .tdZhaoyao {
        width: 207px;
      }

      .tdKemu {
        width: 307px;
        position: relative;

        .yue {
          position: absolute;
          bottom: 2px;
          left: 2px;
          z-index: 2;
          font-weight: bold;
        }

        .num {
          position: absolute;
          bottom: 17px;
          right: 5px;
          line-height: 23px;
          font-weight: normal;
          z-index: 2;
        }
      }

      .tdJieFang, .tdDaiFang {
        width: 221px;
      }

      .displayMoney {
        font-weight: bold;
        font-size: 14px;
        letter-spacing: 11px;
        overflow: hidden;
        text-align: right;
        font-family: 'tahoma', serif;
        background-image: url(../assets/moneyUint.png);
        line-height: 60px;
        padding: 0;

        span {
          position: relative;
          right: -5px;
        }
      }

      .h-autocomplete-show {
        border: none;
        border-radius: 0;
      }

      .h-input {
        border: none;
        border-radius: 0;
        height: 60px !important;
        resize: none !important;
        width: 100% !important;
      }

      textarea.h-input {
        height: 60px !important;
      }

      .h-dropdowncustom-show-content {
        width: 100% !important;
      }
    }

    tbody:first-child td {
      border-top: 0 !important;
    }
  }

  .action {
    position: absolute;
    font-size: 16px;
    cursor: pointer;
    display: none;

    &:hover {
      color: @primary-color;
    }
  }

  .h-numberinput-show {
    border-radius: 0;

    &.focusing {
      border: 1px solid #44b449;
      box-shadow: none;
    }

    .h-input {
      font-size: 16px;
      font-weight: bold;
    }
  }
}

.subjects, .summary {
  li {
    padding: 2px 10px;
    cursor: pointer;
    font-size: 12px;
    white-space: nowrap;

    &:hover {
      background: @primary-color;
      color: @white-color;
    }
  }

  &-item-select {
    background: @primary-color;
    color: @white-color;
  }
}

.hoverNum {
  text-align: right;
  padding: 0 10px;
  font-size: 26px;
  font-weight: bold;
  height: 60px;
  line-height: 60px;
}
</style>