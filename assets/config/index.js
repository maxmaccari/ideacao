import production from './production'
import development from './development'

const config = process.env.NODE_ENV == "production" ? production : development

export default config;