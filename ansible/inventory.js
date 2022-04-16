#!/usr/bin/env node
const inventory = {
	"_meta": {
        "hostvars": {
        	"appserver": {
        		"ansible_host": "51.250.64.204"
        	},
        	"dbserver": {
        		"ansible_host": "51.250.66.235"
        	}
        }
    },
    "all": {
    	"children": [
    		"app", "db"
    	]
    },
    "app": {
    	"hosts": [
    		"appserver"
    	]
    },
    "db": {
    	"hosts": [
    		"dbserver"
    	]
    }
};

process.stdout.write(JSON.stringify(inventory))
