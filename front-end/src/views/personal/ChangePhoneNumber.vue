<template>
  <div class="notice-setting-vue">
    <div class="subframe-title">修改手机</div>
    <Form v-width="300" mode="block" :model="model" :rules="validationRules" ref="form">
      <FormItem label="手机号" prop="mobile">
        <Row type="flex" :space-x="20">
          <Cell :flex="1">
            <input type="text" v-model="model.mobile"/>
          </Cell>
          <Cell v-width="110" class="text-right">
            <SmsVerificationCode :disabled="model.mobile==account.mobile" :mobile="model.mobile"/>
          </Cell>
        </Row>
      </FormItem>
      <FormItem label="验证码" prop="verificationCode">
        <input type="text" v-model="model.verificationCode"/>
      </FormItem>
      <FormItem>
        <Button @click="save" color="primary" :loading="isLoading">保存</Button>
      </FormItem>
    </Form>
  </div>
</template>
<script>
  import SmsVerificationCode from "../../components/SmsVerificationCode";
  import {mapGetters} from "vuex";


  export default {
    name: "ChangePhoneNumber",
    components: {SmsVerificationCode},
    data() {
      return {
	      isLoading:false,
        model: {
          verificationCode: null,
          mobile: null,
        },
        validationRules: {
          required: ['verificationCode', 'mobile'],
          mobile: ['mobile']
        }
      };
    },
    mounted() {
      this.model.mobile = this.account.mobile;
    },
    methods: {
	    save() {
		    let validResult = this.$refs.form.valid();
		    if (validResult.result) {
			    this.isLoading = true;
			    this.$api.common.changePhoneNumber(this.model).then(() => {
				    this.$Message('更新手机号成功');
				    this.isLoading = false;
				    this.$store.dispatch("init");
			    }).catch(() => {
				    this.isLoading = false;
			    });
		    }
	    }
    },
	  computed: {
		  ...mapGetters(['account'])
	  }
  };
</script>
