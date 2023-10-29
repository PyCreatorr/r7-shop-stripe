import { Controller } from "@hotwired/stimulus"
// import _ from "lodash"

export default class extends Controller {

    static targets = [ "toggleable" ];                  

    // toggle function will be here 
  connect() {
    //this.element.textContent = "Hello World!!!"
  };

  toggle() {
    console.log(this.toggleableTarget);
    this.toggleableTarget.classList.toggle("hidden");    
 };


  handleClick() {
    // this.element.textContent = "Clicked!"
    //this.element.textContent = _.intersection([2, 1], [2, 3]);
  };
}
