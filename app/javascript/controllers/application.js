import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.css";

document.addEventListener("DOMContentLoaded", () => {
  flatpickr(".timepicker", {
    enableTime: true,
    noCalendar: true,
    dateFormat: "h:i K", // 12-hour format with AM/PM
    time_24hr: false // Use 12-hour format
  });
});
