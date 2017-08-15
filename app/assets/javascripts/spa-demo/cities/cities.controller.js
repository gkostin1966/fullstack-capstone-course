(function() {
  "use strict";

  angular
    .module("spa-demo.cities")
    .controller("spa-demo.cities.CitiesController", CitiesController);

  CitiesController.$inject = ["spa-demo.cities.City"];

  function CitiesController(City) {
    var vm = this;

    vm.cities;
    vm.city;
    vm.edit = edit;
    vm.create = create;
    vm.update = update;
    vm.remove = remove;

    activate();
    return;
    ///////////////////
    function activate() {
      newCity();
      vm.cities = City.query();
    }

    function newCity() {
      vm.city = new City();
    }

    function handleError(response) {
      console.log(response);
    }

    function edit(object, index) {

    }

    function create() {
      //console.log("creating city", vm.city);
      vm.city.$save()
        .then(function (response) {
          // console.log(response);
          vm.cities.push(vm.city);
          newCity();
        })
        .catch(handleError)
    }

    function update() {

    }

    function remove() {

    }

    function removeElement(elements, element) {

    }
  }
})();