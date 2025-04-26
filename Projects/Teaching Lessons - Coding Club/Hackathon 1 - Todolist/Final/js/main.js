/**
 * Created by andrewapperley on 14-11-23.
 */

$("#add-new-task-btn").click(function() {
    add_new_task($("#todolist-new-task-text").val());
});


var tasks = [];


function add_new_task(task) {
    task = task.trim();
    if (task == null || task == "") {
        return;
    }
    tasks.push(task);
    var task_list = $("#task-list");
    task_list.append(
        "<li id='"+(tasks.length-1)+"' class='task'>"+
        "<p class='task-text'>"+task+"</p>"+
        "<p onclick='remove_task(this);' data-id='"+(tasks.length-1)+"' class='finish-task-btn fa fa-check-circle-o'></p>"+
        "<div class='clearfix'></div>"+
        "</li>");
    $("#todolist-new-task-text").val("");
}

function remove_task(btn) {
    var id = $(btn).attr("data-id");
    tasks.splice(id, 1);
    $("li#"+id).remove();
}