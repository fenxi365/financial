<template>
  <app-content class="h-panel">
    <Tabs :datas="tabDatas" v-model="selected"></Tabs>
    <div class="h-panel-body padding">
      <component :is="selected"></component>
    </div>
  </app-content>
</template>

<script>
/**
 *   门店映射<br>
 进销存组织--->财务组织  .....  <B>默认自动按名称匹配</B><br>
 郑五花哥伦布广场店--->郑五花哥伦布广场店<br>
 郑五花哥伦布广场店--->郑五花哥伦布广场店<br>
 郑五花哥伦布广场店--->郑五花哥伦布广场店<br>
 郑五花哥伦布广场店--->郑五花哥伦布广场店<br>
 郑五花哥伦布广场店--->郑五花哥伦布广场店<br>
 郑五花哥伦布广场店--->郑五花哥伦布广场店<br>
 郑五花哥伦布广场店--->郑五花哥伦布广场店<br><br>
 <Button>保  存</Button>
 */
import LinkJxcAccountSet from './jxc/LinkJxcAccountSet'
import SetJxcParam from './jxc/SetJxcParam'

export default {
  name: "JxcSetting",
  components: {LinkJxcAccountSet,SetJxcParam},
  data() {
    return {
      tabDatas: [
        {
          title: '关联进销存账套',
          key: 'LinkJxcAccountSet'
        }, {
          title: '设置进销存核算项目',
          key: 'SetJxcParam'
        }],
      selected: 'LinkJxcAccountSet',
    };
  },
};
</script>
<style lang="less" scoped>

</style>
