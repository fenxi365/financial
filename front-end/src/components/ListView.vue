<template>
  <div class="h-list-view">
    <div @click="onSelect(item)" class="h-list-view-item"
         :class="{'h-list-view-item-selected':selected[keyField]===item[keyField],'h-list-view-action-hover':hoverAction}"
         v-for="item in datas" :key="item[keyField]">
      <div class="h-list-view-content" :class="contentClass" :style="contentStyle">
        <template v-if="!$scopedSlots.title">
          {{ item[nameField] }}
        </template>
        <slot v-else name="title" :data="item"></slot>
      </div>
      <div v-if="$scopedSlots.actions" class="h-list-view-action" @click.stop>
        <slot name="actions" :data="item"></slot>
      </div>
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
 * <li>Creation    : 2022/6/16 10:31</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
const prefix = 'h-list-view';

export default {
  name: "ListView",
  props: {
    datas: Array,
    hoverAction: {
      type: Boolean,
      default: true
    },
    value: Object,
    contentClass: String,
    contentStyle: Object,
    keyField: {
      type: String,
      default: 'id'
    },
    nameField: {
      type: String,
      default: 'name'
    }
  },
  data() {
    return {
      selected: {}
    };
  },
  watch: {
    value(val) {
      this.selected = val || {};
    }
  },
  methods: {
    onSelect(item) {
      this.selected = item;
      this.$emit('input', item);
    }
  },
  mounted() {
    this.selected = this.value || {};
  }
}
</script>

<style scoped lang="less">
@list-view-prefix: ~"@{prefix}list-view";

.@{list-view-prefix} {
  &-item {
    cursor: pointer;
    position: relative;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-right: 10px;
    transition: color 0.2s;

    &-selected {
      background-color: @primary2-color;
      color: @primary-color;

      &:after {
        position: absolute;
        content: '';
        top: 0;
        right: 0;
        bottom: 0;
        background-color: @primary-color;
        width: 5px;
        transition: 0.2s;
      }
    }

    &:hover {
      background-color: fade(@primary2-color, 10%);
    }
  }

  &-content {
    overflow: hidden;
    text-overflow: ellipsis;
    position: relative;
    padding: 15px;
    cursor: pointer;
    white-space: nowrap;

    &:hover {
      color: @primary-color;
    }
  }

  &-action-hover &-action {
    display: none;
  }

  &-action-hover:hover &-action {
    display: inline-block;
  }
}
</style>