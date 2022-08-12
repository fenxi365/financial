<template>
	<div>
		<Row class="padding-left" type="flex" :space-x="10">
			<Cell class="label">模板名称：</Cell>
			<Cell><input v-model="form.name" type="text"></Cell>
			<Cell class="label">模板类型：</Cell>
			<Cell><Select v-width="200" v-model="form.type" dict="voucherTemplateType" :deletable="false"/></Cell>
		</Row>
		<VoucherTable v-model="voucherTable"/>
		<div class="padding-top-bottom padding-left">
			<Button color="primary" @click="save">保存</Button>
			<Button @click="$router.back()">取消</Button>
		</div>
	</div>
</template>

<script>
	import VoucherTable from "../../../components/VoucherTable";

	export default {
		name: 'TemplateDesign',
		components: {VoucherTable},
		props: {
			templateId: [Number, String],
		},
		data() {
			return {
				form: {
					name: '',
					type: 0,
				},
				voucherTable: {voucherItems: []}
			};
		},
		computed: {
			voucherItems() {
				return this.voucherTable.voucherItems;
			}
		},
		methods: {
			save() {
				if (!this.form.name) {
					this.$Message("亲，请输入模板名称！");
					return
				}

				if (!this.voucherItems.length) {
					this.$Message("亲，第1行不能为空！");
					return
				}

				let i = 0, len = this.voucherItems.length, row = -1;
				for (; i < len; i++) {
					if (!this.voucherItems[i].summary) {
						row = i + 1;
						break
					}
				}

				if (row > -1) {
					this.$Message("亲，第" + row + "行，请输入摘要！");
					return
				}

				this.$api.setting.voucherTemplate[this.templateId ? 'update' : 'save'](Object.assign({}, this.form, {details: this.voucherItems})).then(() => {
					this.$router.back();
				})

			}
		},
		mounted() {
			if (this.templateId) {
				this.$api.setting.voucherTemplate.load(this.templateId).then(({data}) => {
					this.voucherTable = {voucherItems: data.details}
					this.form = {
						id: data.id,
						name: data.name,
						type: data.type
					};
				})
			}
		}
	};
</script>

<style>

</style>
