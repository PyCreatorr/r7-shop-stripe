import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    //this.element.textContent = "Hello World!"

    console.log('js work!!');
  }

  clearInput(){
    console.log("resetting form");
    this.inputTarget.value = "";
  }

  stripeCheckout(){   
    
    const stripe = Stripe("<%= Rails.application.credentials[:stripe][:public] %>");  
    console.log('stripe = ', stripe); 

    stripe.redirectToCheckout({
        // sessionId: '<%= @session.id %>'
        //sessionId: '<%= @session.id %>'
      });
  }


}
