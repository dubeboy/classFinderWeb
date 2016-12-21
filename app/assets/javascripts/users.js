

// $(window).bind("load", function() {
//     $('#cat1').click(function(){
//         $('#1b').append("<h3>These Are the rooms that students have booked for viewing</h3>");
//     });
//
//     $('#cat2').click(function(){
//         $('#1b').append("<h3>These are student who want to review rooms</h3>");
//     });
//     $('#cat3').click(function(){
//         $('#b1').append("<h3>These are all the students who say they have paid, please confirm by checking against their reference number and then click paid</h3>");
//     });
//     $('#cat4').click(function(){
//         $('#b1').append("<h3>These a rooms that the student has fully paid</h3>");
//     });
//
// });

$('#cat1').click(function(){
    $(window).bind("load", function() {
        $('#1b').append("<h3>These Are the rooms that students have booked for viewing</h3>");
    });
});