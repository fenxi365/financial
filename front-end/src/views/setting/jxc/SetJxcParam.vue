<template>
  <div class="box">
    <Tabs :datas="tabDatas" v-model="selected" class-name="h-tabs-card"></Tabs>
    <component :is="selected"></component>
  </div>
</template>

<script>
/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/14 15:43</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
import SupplierMapping from './SupplierMapping'
import MaterialMapping from './MaterialMapping'
export default {
  name: "SetJxcParam",
  components: {SupplierMapping,MaterialMapping},
  data() {
    return {
      tabDatas: [
        {
          title: '供货商映射',
          key: 'SupplierMapping'
        }, {
          title: '物料映射',
          key: 'MaterialMapping'
        }],
      selected: 'SupplierMapping',
    }
  },
}
</script>
