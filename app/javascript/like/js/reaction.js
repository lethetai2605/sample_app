$(document).on('turbolinks:load', function() {
$(".reaction").on("click", function(){   // like click
  var react_id = $(this).parent().parent().attr("id");
  var data_reaction = $(this).attr("data-reaction");

  $(".like-details").html("");
  $("#" + react_id).find(".like-btn-emo").removeClass().addClass('like-btn-emo').addClass('like-btn-' + data_reaction.toLowerCase());
  $("#" + react_id).find(".like-btn-text").text(data_reaction).removeClass().addClass('like-btn-text').addClass('like-btn-text-' + data_reaction.toLowerCase()).addClass("active");
  var href = $("#" + react_id).find('a').attr('href').substring(0, $("#" + react_id).find('a').attr('href').indexOf("=") + 1);
  var id;
  switch(data_reaction.toLowerCase()) {
	case 'like':
	  id = 1;
	  break;
	case 'love':
	  id = 2;
	  break;
	case 'haha':
	  id = 3;
	  break;
	case 'wow':
	  id = 4;
	  break;
	case 'sad':
	  id = 5;
	  break;
	case 'angry':
	  id = 6;
	  break;		  
	default:
	  id = 0;
	  break;
  }
  $("#" + react_id).find('a').first().attr('href', href + id);
  $("#" + react_id).find('a').get(0).click();
});

$(".like-btn-text").on("click", function(){ // undo like click
  var react_id = $(this).parent().attr("id");
  $("#" + react_id).find('a').get(1).click();

  $("#" + react_id).find(".like-btn-text").text("Like").removeClass().addClass('like-btn-text');
  $("#" + react_id).find(".like-btn-emo").removeClass().addClass('like-btn-emo').addClass("like-btn-default");
  $("#" + react_id).find(".like-btn-emo").html('<span class="like-btn-like"></span>');
  $(".like-details").html("");
  })
});