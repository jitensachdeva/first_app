/**
 * Created by jitendrasachdeva on 28/07/14.
 */

var Calculator = function (templateSelector) {
    console.log($(templateSelector).clone());
    //$('#wrapper').append($(templateSelector).clone());
    this.container = $(templateSelector).clone().appendTo('#wrapper');
    this.command = this.container.find('.command');
    this.button = this.container.find('.button');
    this.value = this.container.find('.value')[0];
    this.error = this.container.find('.error')[0];
    this.commandHistory = this.container.find('.commandHistory')[0];
    this.created = false;
    this.observers = $({});
    this.initialize();
};

Calculator.prototype = {

    initialize: function () {

        console.log('inside initialize');
        console.log(this.button);
        //var self = this
        this.button.click(this.click_handler.bind(this));
    },

    click_handler: function () {
        console.log('clicked call on -');
        console.log(this);
        if (!this.created) {
            this.create();
        }
        this.performOperation();

    },

    create: function () {
        console.log("called create function");
        console.log(self);
        //console.log(self.error);
        console.log("this");
        console.log(this);
        $.ajax({
            type: "POST",
            url: "/api/create"

        })
            .done(this.process_create_response.bind(this));
    },

    process_create_response: function (data, textStatus, jqXHR) {
        console.log("inside done of create");
        console.log(self);
        console.log(self.error);

        console.log("this");
        console.log(this);

        console.log("status-->" + textStatus);
        console.log("response code -->" + jqXHR.statusCode);
        console.log("response code -->" + jqXHR.status);

        this.handleCreateCompleted(undefined,jqXHR);
        this.notify("calculator:create", jqXHR);

    },

    performOperation: function () {
        //var self = this;
        $.ajax({
            type: "PUT",
            url: "/api/update",
            data: {command: this.command.val()}
        })
            .done(this.processUpdateResponse.bind(this));
    },

    processUpdateResponse: function (data, textStatus, jqXHR) {
        console.log("inside processUpdateResponse");
        console.log(self);
        console.log("this");
        console.log(this);
        this.handleUpdateCompleted(undefined,data , this.command.val());
        //self.notify_observers(data,textStatus,jqXHR);
//        $.each(this.observers, function(index, observers){
//            observers.trigger("calculator:update");
//        })
        this.notify("calculator:update", [data, this.command.val()]);
    },

    handleUpdateCompleted: function(event,data, command){

        console.log("inside handleUpdateCompleted");
        console.log("arguments");

        console.log(arguments);

        console.log(this);
        console.log("data");
        console.log(data);
        console.log("command");
        console.log(command);
        console.log("commandHistory");
        console.log(this.commandHistory);
        this.value.innerHTML = "<h2>result is " + data.result + "</h2>";
        $(this.commandHistory).append("<h3> Operation ->" + command + " . Value ->" + data.result + "</h3>");
    },

    handleCreateCompleted: function(event,jqXHR){
        console.log("inside handleCreateCompleted");
        console.log(this);
        console.log("response code -->" + jqXHR.status);

        if (jqXHR.status == 201) {
            this.error.innerHTML = "<h3>Calculator created.</h3>";
            this.created = true;
        } else if (jqXHR.status == 200) {
            this.error.innerHTML = "<h3>Calculator found.</h3>";
            this.created = true;
        }
    },

    notify: function(event, params){
        console.log("inside notify");
        console.log("this");
        console.log(this);
        console.log("params");
        console.log(params);
        this.observers.trigger(event, params );
    },

    registerObserver: function (otherCalculator) {
        console.log("inside registerObserver");
        console.log("this");
        console.log(this);
        console.log("otherCalculator");
        console.log(otherCalculator);
        this.observers.on("calculator:create", otherCalculator.handleCreateCompleted.bind(otherCalculator));
        this.observers.on("calculator:update", otherCalculator.handleUpdateCompleted.bind(otherCalculator));
    }

};

function registerObservers(newCalculator){
    for(var i=0; i < calculatorArray.length ; i++){
        calculatorArray[i].registerObserver(newCalculator);
        newCalculator.registerObserver(calculatorArray[i]);
    }
    calculatorArray.push(newCalculator);
}

$('document').ready(function () {
    console.log("I am ready now");
//    var calculator = new Calculator('#calculator1');
//    var calculator2 = new Calculator('#calculator2');
//    calculator.registerObserver(calculator2);
//    calculator2.registerObserver(calculator);
    calculatorArray= [];

    $('#addCalculatorButton').click(function () {
        console.log("clicked button add calculator");
        var calculator = new Calculator("#template #container");
        registerObservers(calculator);
    });
});

