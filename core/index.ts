import { App } from "astal/gtk3";
import style from "./style.scss"

type App = [string, {}];

type Config = {
	apps: Array<App>,
}

const Core = {
	start(config: any) {
		App.start({
			css: style,
			instanceName: "astal-lab_core",
			main() {
				for (let [pkg, cfg] of config.apps) {
					pkg = pkg.replace(/^astal-labs\/core/, ".")
					import(pkg).then(instance => {
						App.get_monitors().map(instance.default)
					}).catch(err => {
						console.log(err)
					})
				}
			},

		});
	}
}

export default Core;

