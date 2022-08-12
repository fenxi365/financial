<template>
	<app-content class="h-panel">
		<Loading text="数据加载中..." :loading="loading"></Loading>
		<div class="h-panel-bar">
			<span class="h-panel-title"><template v-if="report">{{report.name}}</template>&nbsp;</span>
			<Button class="float-right" @click="$router.back()">返回</Button>
		</div>
		<div class="margin-top margin-left margin-right">
      <span class="dark4-color">*提示：按 Ctrl + F 键并输入称可以查找科目。</span>
			<router-link tag="button" class="h-btn float-right" v-if="User.role!=='View'" :to="{name:'TemplateForm',params:{templateId:reportId}}">编辑数据项</router-link>
		</div>
		<div class="h-panel-body">
			<Table class="small-td" :datas="templateItems" selectRow border v-if="report.type==0">
				<TableItem title="名称">
					<div slot-scope="{data}" :class="{'font-bold':data.isBolder}" :style="{paddingLeft:((data.level-1)*15)+'px'}">{{data.title}}</div>
				</TableItem>
				<TableItem title="行次">
					<template slot-scope="{data}">
						{{data.isClassified ? '':data.lineNum>-1?data.lineNum:''}}
					</template>
				</TableItem>
				<TableItem title="本年累计金额" align="right">
					<template slot-scope="{data}">
						{{reportData[data.id]?reportData[data.id].currentYearAmount:''|numFormat}}
					</template>
				</TableItem>
				<TableItem title="本期金额" align="right">
					<template slot-scope="{data}">
						{{reportData[data.id]?reportData[data.id].currentPeriodAmount:''|numFormat}}
					</template>
				</TableItem>
			</Table>
			<Table :datas="templateItemsRender" selectRow border v-else-if="report.type == 1">
				<TableItem title="资产">
					<div slot-scope="{data}" :class="{'font-bold':data.isBolder}" :style="{paddingLeft:((data.level-1)*15)+'px'}">{{data.title}}</div>
				</TableItem>
				<TableItem title="行次">
					<template slot-scope="{data}">
						{{data.isClassified ? '':data.lineNum>-1?data.lineNum:''}}
					</template>
				</TableItem>
				<TableItem title="期末余额" align="right">
					<template slot-scope="{data}">
						{{reportData[data.id]?reportData[data.id].currentPeriodAmount:''|numFormat}}
					</template>
				</TableItem>
				<TableItem title="年初余额" align="right">
					<template slot-scope="{data}">
						{{reportData[data.id]?reportData[data.id].currentYearAmount:''|numFormat}}
					</template>
				</TableItem>
				<TableItem title="负债和所有者权益">
					<div slot-scope="{data}" :class="{'font-bold':data.fs_isBolder}" :style="{paddingLeft:((data.fs_level-1)*15)+'px'}">{{data.fs_title}}</div>
				</TableItem>
				<TableItem title="行次">
					<template slot-scope="{data}">
						{{data.fs_isClassified ? '':data.fs_lineNum>-1?data.fs_lineNum:''}}
					</template>
				</TableItem>
				<TableItem title="期末余额" align="right">
					<template slot-scope="{data}">
						{{reportData[data.fs_id]?reportData[data.fs_id].currentPeriodAmount:''|numFormat}}
					</template>
				</TableItem>
				<TableItem title="年初余额" align="right">
					<template slot-scope="{data}">
						{{reportData[data.fs_id]?reportData[data.fs_id].currentYearAmount:''|numFormat}}
					</template>
				</TableItem>
			</Table>
		</div>
	</app-content>
</template>

<script>
	import {mapState} from 'vuex'

	export default {
		name: "ReportView.vue",
		props: {
			reportId: [Number, String]
		},
		data() {
			return {
				report: {},
				reportData: {},
				accountDate: null,
        orgId: null,
				loading: false
			}
		},
		computed: {
			...mapState(['User','orgDatas', 'currentOrgId']),
			templateItems() {
				return this.report ? this.report.items : [];
			},
			templateItemsRender() {
				if (this.report.type === 1) {
					//所有资产
					let zc = this.templateItems.filter(val => val.type === 0);
					let sq = this.templateItems.filter(val => val.type !== 0);
					sq.forEach((val, index) => {
						let changeObj = {
							fs_id: val.id,
							fs_lineNum: val.lineNum,
							fs_isBolder: val.isBolder,
							fs_level: val.level,
							fs_isClassified: val.isClassified,
							fs_title: val.title
						};
						if (zc[index]) {
							Object.assign(zc[index], changeObj);
						}
					});
					return zc;
				}
				return [];
			}
		},
		watch: {
			accountDate() {
				this.loadReport();
			},
      orgId() {
				this.loadReport();
			},
			reportId() {
				this.loadReport();
			}
		},
		methods: {
			loadReport() {
				Api.report.template.load(this.reportId).then(({data}) => {
					this.report = data;
					// this.$nextTick(this.loadReportData);
				});
			},
			loadReportData() {
				if (this.accountDate){
          this.loading = true;
          Api.report.view(this.reportId, {accountDate: this.accountDate,orgId:this.orgId}).then(({data}) => {
            this.reportData = data;
          }).finally(() => this.loading = false);
        }
			}
		},
    mounted() {
      if (this.currentOrgId) {
        this.orgId = this.currentOrgId;
      }
    }
  }
</script>

<style scoped>
	div.font-bold {
		font-size: 14px;
	}
</style>