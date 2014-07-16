// This script is responsible for ordering/nesting the collections in the sidebar

Blacklight.onLoad(function(){
  $('#orderable-course-collections, #orderable-personal-collections').nestable({ maxDepth: 3 });
  updateWeightsAndRelationships($('#orderable-course-collections, #orderable-personal-collections'));
});

function updateWeightsAndRelationships(selector){
  $.each(selector, function() {
    $(this).on('change', function(event){
      // Scope to a container because we may have two orderable sections on the page (e.g. About page has pages and contacts)
      container = $(event.currentTarget);
      var data = $(this).nestable('serialize')
      var weight = 0;
      for(var i in data){
        var parent_id = data[i]['id'];
        parent_node = findNode(parent_id, container);
        setWeight(parent_node, weight++);
        if(data[i]['children']){
          var children = data[i]['children'];
          for(var child in children){
            var id = children[child]['id']
            child_node = findNode(id, container);
            setWeight(child_node, weight++);
            setParent(child_node, parent_id);
          }
        } else {
          setParent(parent_node, "");
        }
      }
    });
  });
}

function setParent(node, parent_id) {
  parent_page_field(node).val(parent_id);
}

/* find the input element with data-property="parent_page" that is nested under the given node */
function parent_page_field(node){
  return find_property(node, "parent_page");
}
