package main

import (
	"dagger.io/dagger"
)

dagger.#Plan & {
	client: {
		commands: kubeconfig: {
			name: "cat"
			args: ["\(env.KUBECONFIG)"]
			stdout: dagger.#Secret
		}
		env: {
			KUBECONFIG:            string
			NETWORK_TYPE:          string | *"default" // "default" or "cn"
			DOMAIN:                string | *"h8r.site"
			HLN_WITHOUT_DASHBOARD: string | *"false"
		}
	}

	actions: up: #Plan & {
		domain:           client.env.DOMAIN
		networkType:      client.env.NETWORK_TYPE
		kubeconfig:       client.commands.kubeconfig.stdout
		withoutDashboard: client.env.HLN_WITHOUT_DASHBOARD
	}
}
