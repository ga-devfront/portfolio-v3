module.exports = {
    apps: [
        {
            name: 'preprod-portfolio',
            port: '3000',
            exec_mode: 'cluster',
            instances: 'max',
            script: './.output/server/index.mjs'
        }
    ]
}
