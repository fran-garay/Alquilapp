//= require_tree .
//= require_self
//= require jquery3
//= require popper
//= require bootstrap

import "jquery"
import "jquery_ujs"
import "popper"
import "bootstrap"

import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }