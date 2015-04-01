// $(document).ready(function() {
//     $('.list_data_table').DataTable({
//       "bSort": false,
//       "bFilter": false,
//       "bInfo": false,
//       "bPaginate": false,
//       "columnDefs": [{ "visible": false, "targets": 1 }],
//       "order": [[ 1, 'asc' ]],
//       "displayLength": 25,
//       "drawCallback": function ( settings ) {
//             var api = this.api();
//             var rows = api.rows( {page:'current'} ).nodes();
//             var last=null;
 
//             api.column(1, {page:'current'} ).data().each( function ( group, i ) {
//                 if ( last !== group ) {
//                     $(rows).eq( i ).before(
//                         '<tr class="group"><td colspan="2">'+group+'</td></tr>'
//                     );
 
//                     last = group;
//                 }
//             } );
//         }
//     });

//     $('#data_table').DataTable({
//       "bSort": false,
//       "bFilter": false,
//       "bInfo": false,
//       "bPaginate": false
//     });
    
//   });
