import { Controller } from "@hotwired/stimulus"
//import _ from "lodash"

export default class extends Controller {

    static targets = [ "dropdownable" ];

                  

    // toggle function will be here 
  connect() {
    //this.element.textContent = "Hello World!!!"
  };

  dropdownHide() {
    //console.log(this.dropdownableTarget);
    this.dropdownableTarget.classList.toggle("hidden");    
 };


  handleClick() {
    // this.element.textContent = "Clicked!"
    //this.element.textContent = _.intersection([2, 1], [2, 3]);
  };
}
