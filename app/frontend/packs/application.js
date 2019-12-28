require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

import 'bulma'
import 'styles'   // import '../styles'

