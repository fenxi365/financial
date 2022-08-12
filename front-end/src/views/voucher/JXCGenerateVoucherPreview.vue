<template>
  <div class="w-1000px">
    <Loading :text="msg" :loading="loading"/>
    <div class="p-10px" style="max-height: 80vh;overflow-y: auto">
    </div>
    <div class="h-modal-footer">
      <Button :loading="loading" @click="$emit('close')" icon="fa fa-close">取消</Button>
      <Button :disabled="can" :loading="loading" @click="doGenerate" color="primary" icon="fa fa-save">
        确认生成{{ voucherList.length }}张凭证
      </Button>
    </div>
  </div>
</template>

<script>
/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/16 14:22</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
import {groupBy} from "xe-utils";
export default {
  name: "JXCGenerateVoucherPreview",
  props: {
    type: Number,
    records: Array,
  },
  computed: {
    voucherItemMap() {
      let map = {};
      this.subjectMap.forEach(item => {
        map[item.id] = item
      });
      return map;
    },
    can() {
      return this.hasError || this.voucherList.findIndex(value => this.dcommafy(value.jie) !== this.dcommafy(value.dai)) !== -1;
    },
    checkSupplier() {
      if (this.type === 1 || this.type === 2) {//判断是否需要验证供应商
        return true;
      }
      return false;
    }
  },
  data() {
    return {
      loading: false,
      subjectMap: [],
      bookIdMap: {},
      supplierMap: {},
      voucherList: [],
      errors: null,
      hasError: false,
      msg: '正在生成中~'
    }
  },
  methods: {
    async init() {
      //获取映射科目信息
      let subjectMapResponse = [];
      if (subjectMapResponse.data.success) {
        this.subjectMap = subjectMapResponse.data.data;
        if (!this.subjectMap || !this.subjectMap.length) {
          this.$Message.error("辅助核算物料未配置科目映射，无法生成凭证");
          this.$emit('close');
          return Promise.reject("辅助核算物料未配置科目映射，无法生成凭证")
        }
      }
      //获取供应商科目信息
      if (this.checkSupplier) {
        let supplierResponse = [];
        if (supplierResponse.data.success) {
          this.vendorMap = supplierResponse.data.data;
          if (!this.supplierMap) {
            this.$Message.error("辅助核算供应商未进行凭证映射，无法生成凭证");
            this.$emit('close');
            return Promise.reject("辅助核算供应商未进行凭证映射，无法生成凭证");
          }
        }
      }
    },
    async generateVoucherList() {
      const total = this.records.length;
      let current = 1;
      let voucherList = [];
      for (let i = 0; i < this.records.length; i++) {
        const val = this.records[i];
        this.msg = `共${total}条,当前正在生成第${current}条...`;
        //获取详情
        let detailResponse = await this.$api.setting.Inventory.orderDetail(val.id);
        if (detailResponse.data.success) {
          //明细
          let detailRecords = detailResponse.data.data;
          let groupByMateriel = groupBy(detailRecords, (val) => val.orderDetail.materielId, this);
          let materielAmount = {};
          Object.keys(groupByMateriel).forEach(val => {
            materielAmount[val.orderDetail.materielId] = {
              materielName: groupByMateriel[val.orderDetail.materielId][0].materiel.name,
              amount: groupByMateriel[val.orderDetail.materielId].reduce((total, currentValue) => {
                return total + Number(currentValue.orderDetail.amount);
              }, 0)
            };
          });
        }
      }
    },
    doGenerate() {

    }
  },
  created() {
    this.init().then(() => {
      this.loading = true;
      this.generateVoucherList();
    });
  }
}
</script>

<style scoped>

</style>