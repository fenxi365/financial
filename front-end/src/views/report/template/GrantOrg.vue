<template>
  <div>
    <div class="padding">
      <Form :labelWidth="60" ref="grantForm" :rules="grantValidationRules" :model="grantForm">
        <FormItem label="组织" prop="orgIds">
          <TreePicker :option="orgOption" multiple choose-mode="independent"
                      ref="orgTreePicker" v-model="grantForm.orgIds"></TreePicker>
        </FormItem>
      </Form>
    </div>
    <footer class="h-modal-footer">
      <Button @click="$emit('close')" :loading="loading">取消</Button>
      <Button color="primary" :loading="loading" @click="grantSave()">确认</Button>
    </footer>
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
 * <li>Creation    : 2022/6/9 15:13</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
export default {
  name: "GrantOrg",
  props: {
    template: Object,
  },
  computed: {
    ...mapState(['orgDatas']),
  },
  data() {
    return {
      loading: false,
      grantForm: {
        orgIds: [],
        template: null,
      },
      orgOption: {
        keyName: 'id',
        parentName: 'parentId',
        titleName: 'title',
        dataMode: 'list',
        datas: []
      },
      grantValidationRules: {
        required: ['orgIds'],
      },
    }
  },
  methods:{
    grantSave() {
      let validResult = this.$refs.grantForm.valid();
      if (validResult.result) {
        this.loading = true;
        this.$api.report.template.grant(this.grantForm).then(({data}) => {
          this.$emit('success');
        }).finally(() => {
          this.loading = false;
        });
      }
    },
  },
  created() {
    this.grantForm.template = this.template;
    this.grantForm.orgIds = [];
    this.orgOption.datas = this.orgDatas.map(val => {
      return {
        id: val.id,
        name: val.name,
        type: val.type,
        title: `[${val.code}]${val.name}`,
        parentId: val.parentId,
      }
    });
    this.$nextTick(() => {
      this.$refs.orgTreePicker.expandAll();
    });
  }
}
</script>

<style scoped>

</style>