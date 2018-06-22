import Vuex from 'vuex';
import Vue from 'vue';

import createPersistedState from "vuex-persistedstate";

import state from './state'
import getters from './getters'
import mutations from './mutations'
import actions from './actions'

Vue.use(Vuex);

const store = new Vuex.Store({
  plugins: [createPersistedState({key: '__ideacao_state', paths: ['ideas', 'user', 'authToken']})],
  state,
  getters,
  mutations,
  actions
})

export default store;