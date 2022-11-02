
//= require_tree .
//= require_self
//= require jquery
//= require jquery_ujs

import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
