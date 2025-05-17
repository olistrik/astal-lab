import { App } from "astal/gtk3"
import style from "./style.scss"

App.start({
	css: style,
	instanceName: "astal-lab_core",
	main() {
		import("./widget/Bar").then((Bar) => {
			App.get_monitors().map(Bar.default)
		})
	},
})
