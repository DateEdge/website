$ ->
  $("#user_label_id").change ->
    if parseInt($(this).val()) == 4 # hardcoded DB ID
      $("#drug-use").removeClass('hidden')
    else
      $("#drug-use").addClass('hidden')
