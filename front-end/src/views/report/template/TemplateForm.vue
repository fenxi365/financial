<template>
	<app-content class="h-panel">
		<div class="h-panel-bar">
			<span class="h-panel-title">{{template.name}} - 数据项</span>
			<button @click="$router.back()" class="h-btn float-right">返回</button>
		</div>
		<div class="margin-top margin-left">
			<Button color="primary" @click="showForm()">添加项目</Button>
		</div>
		<div class="h-panel-body">
			<Table :datas="templateItems" selectRow>
				<TableItem :width="80" align="center">
					<div slot-scope="{data}">{{data.isClassified?'归类':''}}</div>
				</TableItem>
				<TableItem title="名称">
					<div slot-scope="{data}" :class="{'font-bold':data.isBolder}" :style="{paddingLeft:((data.level-1)*15)+'px'}">{{data.title}}</div>
				</TableItem>
				<TableItem title="行次" align="center">
					<div slot-scope="{data}">{{data.isClassified?'':data.lineNum}}</div>
				</TableItem>
				<TableItem title="类型" v-if="template.type == 1">
					<div slot-scope="{data}">{{data.isClassified?'':data.type| dictMapping('reportTemplateItemType')}}</div>
				</TableItem>
				<TableItem title="取数来源">
					<div slot-scope="{data}">{{data.isClassified?'':data.sources| dictMapping('reportTemplateItemSources')}}</div>
				</TableItem>
				<TableItem title="显示位置" prop="pos" :width="80" align="center"></TableItem>
				<TableItem>
					<div class="actions" slot-scope="{data}">
						<span @click="showForm(data)">添加</span>
						<span @click="showForm({id:data.parentId},data)">编辑</span>
						<span v-if="!data.isClassified" @click="showFormulaModal(data,template.type)">公式</span>
						<span @click="remove(data)">删除</span>
					</div>
				</TableItem>
			</Table>
		</div>
		<TemplateItemModal @success="loadTemplate" :template="template" ref="templateItemModal" :templateItems="templateItems"/>
		<TemplateItemFormulaModal @success="loadTemplate" ref="templateItemFormulaModal" :templateItems="templateItems"/>
	</app-content>
</template>

<script>

	import TemplateItemModal from "./TemplateItemModal";
	import TemplateItemFormulaModal from "./TemplateItemFormulaModal";

	export default {
		name: "TemplateForm",
		components: {TemplateItemFormulaModal, TemplateItemModal},
		inject: ['reload'],
		props: {
			templateId: [Number, String]
		},
		data() {
			return {
				template: {},
				templateItemFormulaModel: false,
				templateItem: null,
				templateItemFormula: null,
				templateItemFormulas: []
			}
		},
		computed: {
			templateItems() {
				return this.template.items;
			}
		},
		methods: {
			showForm(parent, org) {
				this.$refs.templateItemModal.toggle(parent, org);
			},
			showFormulaModal(item, type) {
				this.$refs.templateItemFormulaModal.toggle(item, type);
			},
			loadTemplate() {
				Api.report.template.load(this.templateId).then(({data}) => {
					this.template = data;
				});
			},
			remove(data) {
				this.$Confirm("确认删除?").then(() => {
					Api.report.template.items.delete(data.id).then(() => {
						this.loadTemplate();
					})
				})
			}
		},
		mounted() {
			this.loadTemplate()
		}
	}
</script>

