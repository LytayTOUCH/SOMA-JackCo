//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require bootstrap/scrollspy
//= require bootstrap/modal
//= require bootstrap/dropdown
//= require jquery.tokeninput

$(document).ready(function() {
  NProgress.start();

  // $("#labor_project_tokens").tokenInput("/labors/projects.json", {
  //   crossDomain: false,
  //   prePopulate: $("#labor_project_tokens").data("pre"),
  //   theme: "facebook"    
  //   preventDuplicates: true
  // });
});


// $("#listing_listing_category_tokens").tokenInput("/admin/listings/listing_categories.json", {
//       crossDomain: false,
//       prePopulate: $("#listing_listing_category_tokens").data("pre"),
//       theme: "facebook",
//       preventDuplicates: true
//     });