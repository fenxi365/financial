import Vue from 'vue'
import Vuex from 'vuex'
import Common from './api/common'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    User: null,
    currentAccountSets: {},
    currentOrgId: null,
    currentOrg: {},
    myAccountSets: [],
    orgDatas: [],
    sliderCollapsed: false,
  },
  mutations: {
    updateAccount(state, data) {
      state.User = data;
      state.currentAccountSets = data.accountSets;
      state.myAccountSets = data.accountSetsList;
      state.orgDatas = data.orgList || [];
      state.currentOrgId = data.orgId;
      state.currentOrg = data.org;
    },
    updateSliderCollapse(state, isShow) {
      setTimeout(() => {
        G.trigger('page_resize');
      }, 600);
      state.sliderCollapsed = isShow;
    },
    updateCurrentOrgId(state, orgId) {
      state.currentOrgId = orgId;
    },
    updateOrgDatas(state, orgDatas) {
      state.orgDatas = orgDatas;
    }
  },
  actions: {
    init(context) {
      return new Promise((resolve, reject) => {
        Common.init().then(({data}) => {
          context.commit('updateAccount', data);
          resolve(data)
        }).catch(() => {
          reject();
        })
      });
    }
  },
  getters: {
    account: state => {
      return state.User;
    },
    myAccountSets: state => {
      return state.myAccountSets;
    },
    sliderCollapsed: state => {
      return state.sliderCollapsed;
    }
  }
})
