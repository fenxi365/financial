<template>
  <div>
    <div align="right" style="margin: 10px">
      <Button color="primary">批量指定科目</Button>
    </div>
    <vxe-table
        :data="supplierList">
      <vxe-column type="seq" width="60"></vxe-column>
      <vxe-column field="code" title="编码"></vxe-column>
      <vxe-column field="name" title="进销存供货商名称"></vxe-column>
      <vxe-column field="subject" title="财务系统科目"></vxe-column>
    </vxe-table>
  </div>
</template>

<script>
import {mapState} from "vuex";

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/15 13:43</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
export default {
  name: "SupplierMapping",
  data() {
    return {
      supplierList: [],
      subjectList: [],
      loading: false,
    }
  },
  computed: {
    ...mapState(["currentAccountSets"]),
    bindSubjectSupplier() {
      let array = this.subjectList.filter(val => val.supplierId);
      if (array){
        this.supplierList.forEach(m => {
          let s = array.find(s => s.supplierId === m.id)
          if (s) {
            m.subjectId = s.subjectId
          }
        })
      }
      return this.supplierList;
    }
  },
  methods: {
    init() {
      if (this.currentAccountSets.token) {
        this.loading = true
        Promise.all([
          this.$api.setting.Inventory.supplier(),
          this.$api.setting.Inventory.getSupplierMapping()
        ]).then((results) => {
          this.supplierList = results[0].data || [];
          this.subjectList = results[1].data || [];
        }).finally(() => this.loading = true);
      } else {
        this.$Message.error("请先进行进销存设置");
      }
    },
    save() {
      let array = this.supplierList.filter(val => val.subjectId);
      if (array.length) {
        this.loading = true;
        this.$api.setting.Inventory.supplierMapping(array).then(({data}) => {
          this.$Message('映射成功~');
          this.step = 2;
        }).finally(() => this.loading = false);
      } else {
        this.$Message.error("请设置映射科目");
      }
    }
  },
  created() {
    this.init();
  }
}
</script>

<style scoped lang="less">
.form {
  border: @border;
  margin: 30px auto;
  padding: 30px;
  width: 800px;
}

.sys-border {
  padding-left: 10px !important;
  border: 1px solid #f1556c;
}
</style>