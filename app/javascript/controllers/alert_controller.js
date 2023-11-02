import { Controller } from "@hotwired/stimulus"
// import _ from "lodash"

export default class extends Controller {

    static targets = [ "hideable" ];                  

    // toggle function will be here 
  connect() {
    //this.element.textContent = "Hello World!!!"
  };

  hideMe() {
    console.log(this.hideableTarget);
    this.hideableTarget.classList.toggle("hidden");    
 };


  handleClick() {
    // this.element.textContent = "Clicked!"
    //this.element.textContent = _.intersection([2, 1], [2, 3]);
  };
}
