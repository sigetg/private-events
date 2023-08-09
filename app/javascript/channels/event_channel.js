import consumer from "channels/consumer"

consumer.subscriptions.create("EventChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const eventDisplay = document.querySelector('#events')
    eventDisplay.insertAdjacentHTML('beforeend', this.template(data))
  },
  template(data) {
    return `<div class="event">
              <div class="event-header">
                <h2 class="event-name">${data.name}</h2>
                <p class="event-location">${data.location}</p>
              </div>
              <div class="event-details">
                <p class="event-date">${data.date}</p>
              </div>
            </div>`;
  }
});

// document.addEventListener("turbo:load", () => {
//   let form = document.querySelector('#event-form');
//   if (form) {
//     form.addEventListener('submit', (e) => {
//       e.preventDefault();

//       let formData = new FormData(form);

//       // Convert FormData to an object
//       let eventData = {};
//       formData.forEach((value, key) => {
//         eventData[key] = value;
//       });

//       // Send the entire eventData object to the server
//       eventChannel.send({ event: eventData });

//       form.reset();
//     });
//   }
// });