<template>
  <div>
    <div align="right" style="margin: 10px">
      <Button color="primary">批量指定科目</Button>
    </div>
  <vxe-table
      :data="materialList">
    <vxe-column type="seq" width="60"></vxe-column>
    <vxe-column field="code" title="编码"></vxe-column>
    <vxe-column field="name" title="进销存物料名称"></vxe-column>
    <vxe-column field="unitName" title="单位"></vxe-column>
    <vxe-column field="sepic" title="规格"></vxe-column>
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
  name: "MaterialMapping",
  data() {
    return {
      materialList: [],
      subjectList: [],
      loading: false,
    }
  },
  computed: {
    ...mapState(["currentAccountSets"]),
    // bindSubjectMaterial() {
    //   let array = this.subjectList.filter(val => val.materielId);
    //   if (array){
    //     this.materialList.forEach(m => {
    //       let s = array.find(s => s.materielId === m.id)
    //       if (s) {
    //         m.subjectId = s.subjectId
    //       }
    //     })
    //   }
    //   return this.materialList;
    // }
  },
  methods: {
    init() {
      if (this.currentAccountSets.token) {
        this.loading = true
        Promise.all([
          this.$api.setting.Inventory.material(),
          this.$api.setting.Inventory.getMaterialMapping()
        ]).then((results) => {
          this.materialList = results[0].data || [];
          this.subjectList = results[1].data || [];
        }).finally(() => this.loading = true);
      } else {
        this.$Message.error("请先关联进销存账套!");
      }
    },
    save() {
      let array = this.materialList.filter(val => val.subjectId);
      if (array.length) {
        this.loading = true;
        this.$api.setting.Inventory.materialMapping(array).then(({data}) => {
          this.$Message('映射成功~');
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