using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WinFormsApp1
{
    public class xy
    {
        public float x;
        public float y;
    }
    public partial class Form1 : Form
    {
        private delegate void MyInvoke(string str);

        List<xy> lsxy = new List<xy>();
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            Thread thread = new Thread(new ThreadStart(DoSomething));
            thread.Start();
        }

        private void DoSomething()
        {
            this.Invoke(new Action(() => this.textBox1.Text = "Str"));
            //MyInvoke invoke = new MyInvoke(Update);
            //this.BeginInvoke(invoke, new Object[] { "test-2" });
        }

        private void Update(string str)
        {
            textBox1.Text = str;
        }
        Graphics g;
        Pen pen;
        Font font;
        Brush brush;

        int count = 72;
        int rows = 12;

        int width = 76;
        int height = 38;
        int span = 8;
        int hspan =5;
        Bitmap bmp;
        private void CreateBitmap()
        {
            int totalwidth = (count / rows) * width + (count / rows + 1) * span + span; 
            int totalheigh = rows * height + (rows + 1) * hspan - 1; 
            bmp = new Bitmap(totalwidth, totalheigh);
            for (int i = 0; i < rows; i++)
            {
                for (int j = 0; j < count / rows; j++)
                {
                    var xy = new xy();
                    xy.x = span * (j + 1) + (j > 0 ? width * j : 0) - (span / 2) - 1 + ((j > 2) ? Convert.ToInt32(span) * 2 : 0);// +((j==((count / rows)-1))? span : 0);

                    xy.y = hspan * (i + 1) + (i > 0 ? height * i : 0) + (float)0.5;
                    lsxy.Add(xy); 
                } 
            }
        }

        private int GetIndex(string side, int row, int col)
        {
            return side == "L" ? (count / rows) * (row - 1) + col - 1 : (count / rows) * (row - 1) + ((count / rows / 2)) + col - 1;       
        }
        Font drawFont = new Font("Arial", 5);
        SolidBrush drawBrush = new SolidBrush(Color.Black);
        StringFormat drawFormat = new StringFormat(); 
        private void draw()
        {
            drawFormat.FormatFlags = StringFormatFlags.DirectionRightToLeft;
            drawFormat.Alignment = StringAlignment.Center;
            using (Graphics g = Graphics.FromImage(bmp))
            {
                String drawString = "Sample Text";
           
                g.Clear(Color.White);

                for (int i = 0; i < lsxy.Count; i++)
                {
                    if (i == 25)
                        continue;

                    g.DrawRectangle(pen, lsxy[i].x, lsxy[i].y, width, height);

                    // Draw string to screen.
                    g.DrawString(drawString, drawFont, drawBrush, lsxy[i].x + 36, lsxy[i].y + 5, drawFormat);

                    g.DrawString(drawString, drawFont, drawBrush, lsxy[i].x + 36, lsxy[i].y + 15, drawFormat);

                    g.DrawString(drawString, drawFont, drawBrush, lsxy[i].x + 36, lsxy[i].y + 25, drawFormat);
                }

                bmp.Save(@"c:\test\inx\test2.png", ImageFormat.Png); 
                bmp.Dispose();
                g.Dispose();
                GC.Collect();
            }
        }



        //Dictionary<int, int> xy = new Dictionary<int, int>();
        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                //g = this.CreateGraphics();
                pen = new Pen(Color.Black, (float)1.5);
                font = new Font("標楷體", 16);
                brush = new SolidBrush(Color.Black);


                int totalwidth = (count / rows) * width + (count / rows + 1) * span+ span;

                int totalheigh = (rows) * height + (rows + 1) * hspan-1;
                pictureBox1.Width = totalwidth;
                pictureBox1.Height = totalheigh;
                Bitmap bmp = new Bitmap(totalwidth, totalheigh);

                //Graphics g = Graphics.FromImage(bm);
               


               

               

                using (Graphics g = Graphics.FromImage(bmp))
                { 
                    String drawString = "Sample Text"; 
                    Font drawFont = new Font("Arial", 5);
                    SolidBrush drawBrush = new SolidBrush(Color.Black);  
                    StringFormat drawFormat = new StringFormat();
                    drawFormat.FormatFlags = StringFormatFlags.DirectionRightToLeft;
                    drawFormat.Alignment = StringAlignment.Center;
                    g.Clear(Color.White);

                    for (int i = 0; i < lsxy.Count; i++)
                    {
                        if (i == 25)
                            continue;

                        g.DrawRectangle(pen, lsxy[i].x, lsxy[i].y, width, height);

                        // Draw string to screen.
                        g.DrawString(drawString, drawFont, drawBrush, lsxy[i].x + 36, lsxy[i].y + 5, drawFormat);

                        g.DrawString(drawString, drawFont, drawBrush, lsxy[i].x + 36, lsxy[i].y + 15, drawFormat);

                        g.DrawString(drawString, drawFont, drawBrush, lsxy[i].x + 36, lsxy[i].y + 25, drawFormat);
                    }
                  
                    bmp.Save(@"c:\test\inx\test2.png", ImageFormat.Png);
                    //using (MemoryStream memoryStream = new MemoryStream())
                    //{
                    //    memoryStream.Seek(0, SeekOrigin.Begin);
                    //    memoryStream.Position = 0;
                    //    using (var png = Image.FromStream(memoryStream,true))
                    //    {
                    //        //png.Save(@"c:\test\inx\test2.jpeg");
                    //    }
                    //    //Save the Watermarked image to the MemoryStream.
                    //    //bmp.Save(memoryStream, ImageFormat.Png);
                    //    //memoryStream.Position = 0;


                    //}
                    bmp.Dispose();
                    g.Dispose();
                    GC.Collect();
                }










                //g.DrawRectangle(pen, 0, 0, 100, 100);
                //  g.DrawString("Legend", new Font("Tahoma", 12, FontStyle.Bold), Brushes.Black, new PointF(50, 50));

                //pictureBox1.Image = bm;

                //pictureBox1.Image.Save(@"c:\test\inx\test2.jpg", ImageFormat.Jpeg);

                //var image = new Bitmap(width, height);
                //using (MemoryStream ms = new MemoryStream())
                //{
                //    //error will throw from here
                //    bm.Save(ms, ImageFormat.Jpeg);
                //}
                //bm.Save(@"c:\test\inx", ImageFormat.Png);
                //回收资源
              
            }
            catch (Exception ex)
            { 
            
            }
        }
    }
}


@{
   // Layout = "~/Views/Shared/_Layout2.cshtml";
    ViewBag.Title = "Student List";
}
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<h2>Student Record</h2>

<div class="row">
    @Html.AntiForgeryToken()
    <div class="col-md-12">

        <div class="panel panel-primary list-panel" id="list-panel">

            <div class="panel-heading list-panel-heading">

                <h1 class="panel-title list-panel-title">Assets</h1>
            </div>

            <div class="panel-body">
                <div class="table-responsive">

                    <div class="row">
                        @*<div class="col-sm-12">*@

                           @* <div class="row well input-daterange">*@

                                <div class="col-sm-3">
                                    <label class="control-label">Start date</label>
                                    <input class="form-control" type="date" name="initial_date" id="initial_date" placeholder="yyyy-mm-dd" style="height: 40px;" />
                                </div>
                                <div class="col-sm-3">
                                    <label class="control-label">End date</label>
                                    <input class="form-control" type="date" name="final_date" id="final_date" placeholder="yyyy-mm-dd" style="height: 40px;" />
                                </div>
                                <div class="col-sm-2">
                                    <button class="btn btn-success btn-block" type="submit" name="filter" id="filter" style="margin-top: 30px">
                                        <i class="fa fa-filter"></i> Filter
                                    </button>
                                </div>

                           @*  *@ </div>
                        @*</div>*@
                    </div>
                <br>

                            <table id="StudentTable" class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        @*   <th>StudentID</th>*@
                                        <th>Name</th>
                                        <th>Department</th>
                                        <th>Semester</th>
                                        <th>Age</th>
                                        <th>Fees</th>
                                        <th>

                                        </th>
                                    </tr>
                                </thead>

                            </table>

                        </div>
                    </div>
                </div>

    </div>
    <!--bootstra pop up confirmation dialog-->
    <div class="modal fade" id="delete-conformation" tabindex="-1" role="dialog" aria-labelledby="deleteconformation">
        <div class="modal-dialog" style="width:501px !important;margin:0 auto;">
            <div class="modal-content">
                <div class="modal-header" style="background:#d9534f;color:white;">
                    <h4 class="modal-title" id="delete-conformation">
                        Delete Confirmation
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <span>
                                    Are you sure you want to delete?
                                </span>
                                <strong id="deletedValueName">
                                </strong>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <input type="submit" class="btn btn-danger" value="Delete" onclick="deleteData()" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

@section scripts{
    <script>

        $(document).ready(function () {
            //var Fieldparams = ['Name', 'Department', 'Semester', 'Age','Fees'];
            var initial_date = $("#initial_date").val(moment().subtract(7, "days").format('YYYY-MM-DD'));
            var final_date = $("#final_date").val(moment().format('YYYY-MM-DD'));
            var _data;
            $("#filter").click(function () {
                var initial_date = $("#initial_date").val();
                var final_date = $("#final_date").val();
                //var gender = $("#gender").val();
                if (initial_date == '' && final_date == '') {
                    $('#StudentTable').DataTable().destroy();
                    load_data("", "", gender); // filter immortalize only
                } else {
                    var date1 = new Date(initial_date);
                    var date2 = new Date(final_date);
                    var diffTime = Math.abs(date2 - date1);
                    var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                    if (initial_date == '' || final_date == '') {
                        alert("Warning: You must select both (start and end) date.</span>");
                    } else {
                        if (date1 > date2) {
                            alert("Warning: End date should be greater then start date.");
                        } else {
                            //alert.html("");
                            $('#StudentTable').DataTable().destroy();
                            //load_data(initial_date, final_date, gender);
                        }
                    }
                }

                
                $.ajax({
                    url: `/Student/GetData`,
                    headers: { '__RequestVerificationToken': token },
                    success: function (data) {
                        data = JSON.parse(JSON.stringify(data));
                        _data = data.data;
                        Create($('#StudentTable'), "Student", _data);
                    }
                });
            });

          

        });

        @*function PopupForm(url) {

            var formDiv = $('<div/>');
            $.get(url)
                .done(function (response) {

                    formDiv.html(response);

                    Popup = formDiv.dialog({

                        autoOpen : true,
                        resizable : false,
                        title : 'Fill Student Details',
                        height : 500,
                        width : 700,
                        close: function () {

                            Popup.dialog('destroy').remove();
                        }

                    });

                });
        }

        function SubmitForm(form) {

            $.validator.unobtrusive.parse(form);
            if ($(form).valid()) {

            $.ajax({
                type: "POST",
                url: form.action,
                data: $(form).serialize(),
                success: function (data) {

                    if (data.success) {

                        Popup.dialog('close');
                        dataTable.ajax.reload();

                        $.notify(data.message, {
                            globalPosition: "top center",
                            className:"success"
                        })


                    }
                }
                });
            }

            return false;

        }

        function Delete(id) {
            if (confirm('Are you sure to Delete this record ?')) {

                $.ajax({

                    type: "POST",
                    url: '@Url.Action("Delete","Student")/' + id,
                    success: function (data) {

                        if (data.success) {

                            dataTable.ajax.reload();

                            $.notify(data.message, {
                                globalPosition: "top center",
                                className: "success"
                            })

                        }
                    }

                });
            }
        }*@
              //$("#btnadd").append("<a class='btn btn-primary btn-sm' onclick=PopupForm('@Url.Action("StoreOrEdit","Student")?id=&actions=Add" + "')><i class='fa fa-pencil'></i>Add New</a>");

    </script>
}


var Popup, dataTable, tableData;
var token = '';

$(function () {
    token = $('[name=__RequestVerificationToken]').val();
});
function Create(dts, controlname, _data1=null) {
    //var Popup, dataTable;

    var columns = [];
    var aocolumns = [];
    //$.ajax({
    //    url: `/${controlname}/GetData`,
    //    headers: { '__RequestVerificationToken': token },
    //    success: function (data) {
    //        data = JSON.parse(JSON.stringify(data));
    //        columnNames = Object.keys(data.data[0]);
    //        for (var i in columnNames) {
    //            columns.push({
    //                data: columnNames[i]
    //            });
    //        }
    //        dataTable = dts.DataTable({
    //            processing: false,
    //            //serverSide: true,
    //            //ajax: `/${controlname}/GetData`,
    //            //headers: { '__RequestVerificationToken': token },
    //            data: data.data,
    //            //columns: columns,
    //            "columns": [
    //                { "data": "StudentID" },
    //                { "data": "Name" },
    //                { "data": "Department" },
    //                { "data": "Semester" },
    //                { "data": "Age" },
    //                { "data": "Fees" },
    //                {
    //                    "data": "StudentID", "render": function (data) { 
    //                        return `<a class='btn btn-default btn-sm' onclick=PopupForm('${controlname}/StoreOrEdit?id=${data}&actions=edit')><i class='fa fa-pencil'></i>Edit</a> <a class='btn btn-danger btn-sm' style='margin-left:5px' onclick=Delete('${data}')><i class='fa fa-trash'></i>Delete</a>`;
    //                    },
    //                    "orderable": false,
    //                    "searchable": false,
    //                    "width": "150px"
    //                }
    //            ],
    //            //'columnDefs': [
    //            //    { //報錯：DataTables warning : Requested unknown parameter '1' from the data source for row 0
    //            //        //加上這段定義就不出錯了。
    //            //        sDefaultContent: '',
    //            //        //aTargets: ['_all'],
    //            //        targets: -1,
    //            //        data: "StudentID",
    //            //        render: function (data, type, row, meta) {
    //            //            return `<a class='btn btn-default btn-sm' onclick=PopupForm('${controlname}/StoreOrEdit?id=${data}&actions=edit')><i class='fa fa-pencil'></i>Edit</a> <a class='btn btn-danger btn-sm' style='margin-left:5px' onclick=Delete('${data}')><i class='fa fa-trash'></i>Delete</a>`;
    //            //        },
    //            //        "width": "150px",
    //            //        "orderable": false,
    //            //        "searchable": false
    //            //    } 
    //            //],
    //            //aoColumnDefs: [
    //            //    {
    //            //        //報錯：DataTables warning : Requested unknown parameter '1' from the data source for row 0
    //            //        //加上這段定義就不出錯了。
    //            //        sDefaultContent: '',
    //            //        //aTargets: ['_all'],
    //            //        targets: -1,
    //            //        data: "StudentID",
    //            //        render: function (data, type, row, meta) {
    //            //            return `<a class='btn btn-default btn-sm' onclick=PopupForm('${controlname}/StoreOrEdit?id=${data}&actions=edit')><i class='fa fa-pencil'></i>Edit</a> <a class='btn btn-danger btn-sm' style='margin-left:5px' onclick=Delete('${data}')><i class='fa fa-trash'></i>Delete</a>`;
    //            //        },
    //            //        "width": "150px",
    //            //        "orderable": false,
    //            //        "searchable": false
    //            //    }
    //            //],
    //            "language": {
    //                "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json",
    //                //"processing": "<div class='overlay custom-loader-background'>bbbbbbbbbbbbb<i class='fa fa-cog fa-spin custom-loader-color'></i></div>"
    //            },
    //            //oLanguage: {
    //            //    sProcessing: "<div class='overlay custom-loader-background'>bbbbbbbbbbbbb<i class='fa fa-cog fa-spin custom-loader-color'></i></div>"
    //            //},
    //            initComplete: function () {
    //                console.log("The Table has been initialized!")
    //            },
    //            dom: "<'row'<'col-sm-2'f><'col-sm-10 text-right'B>>" +
    //                "<'row'<'col-sm-12'tr>>" +
    //                "<'row'<'col-sm-2'l><'col-sm-2'i><'col-sm-4'><'col-sm-4'p>>",
    //            buttons: [
    //                {
    //                    text: "<a class='btn btn-primary btn-sm' onclick=PopupForm('Student/StoreOrEdit?id=&actions=Add')><i class='fa fa-pencil'></i>Add New</a>",
    //                    attr: {
    //                        id: 'btn-add-review'
    //                    },
    //                    action: function (e, dt, node, config) {
    //                        alert('Button activated');
    //                    },
    //                    initComplete: function () {
    //                        //console.log('Test2');
    //                        var btns = $('#btn-add-review');
    //                        btns.css("border", "none");
    //                    },
    //                    init: function (dt, node, config) {
    //                        //console.log('Test');
    //                        $(node).css("background-color", "transparent");
    //                        $(node).css("border", "none");
    //                    }
    //                }
    //            ],
    //        });
    //    }
    //});

    
    var _data = {};
    $.ajax({
        url: `/${controlname}/GetData`,
        headers: { '__RequestVerificationToken': token },
        success: function (data) {
            data = JSON.parse(JSON.stringify(data));

            //tableData = JSON.parse(data);  //Unexpected token o in JSON at position 1
            //tableData = JSON.parse(JSON.stringify(data));    // Cannot read property '0' of undefined
           
            columnNames = Object.keys(data.data[0]);
            for (var i in columnNames) {

                if (!columnNames[i].endsWith('ID')) {
                    columns.push({
                        data: columnNames[i]//,
                        //class: "center",
                        //title: columnNames[i]
                    });

                }
            }
            let obj =
            {
                data: "StudentID",
                "render": function (data) {
                    return `<a class='btn btn-default btn-sm' onclick=PopupForm('${controlname}/StoreOrEdit?id=${data}&actions=edit')><i class='fa fa-pencil'></i>Edit</a> <a class='btn btn-danger btn-sm' style='margin-left:5px' onclick=Delete('${data}')><i class='fa fa-trash'></i>Delete</a>`;
                },
                "orderable": false,
                "searchable": false,
                "width": "150px"
            };
            //columns.push(obj);
            let aoobj =
            {
                data: "StudentID",
                "render": function (data) {
                    return `<a class='btn btn-default btn-sm' onclick=PopupForm('${controlname}/StoreOrEdit?id=${data}&actions=edit')><i class='fa fa-pencil'></i>Edit</a> <a class='btn btn-danger btn-sm' style='margin-left:5px' onclick=Delete('${data}')><i class='fa fa-trash'></i>Delete</a>`;
                },
                "orderable": false,
                "searchable": false,
                "width": "150px"
            };
             //aocolumns.push(aoobj);
            //columns.push({
            //    data: null,
            //    "render": function (data) {
            //        return `<a class='btn btn-default btn-sm' onclick=PopupForm('${controlname}/StoreOrEdit?id=${data}&actions=edit')><i class='fa fa-pencil'></i>Edit</a> <a class='btn btn-danger btn-sm' style='margin-left:5px' onclick=Delete('${data}')><i class='fa fa-trash'></i>Delete</a>`;
            //    },
            //    "orderable": false,
            //    "searchable": false,
            //    "width": "150px"
            //});
         //   _data = data.data;

            dataTable = dts.DataTable({
                processing: false,
                //"ajax": {

                //    "url": `/${controlname}/GetData`,
                //    "type": "GET",
                //    "datatype": "json"
                //},
                //"ajax":
                //{
                //    "url": `/${controlname}/GetData`,
                //    "type": "GET",
                //    "dataType": "JSON",
                //    "dataSrc": function (json) {
                //        //for (var i = 0, ien = json.data.length; i < ien; i++) {
                //        //    json.data[i][0] = '<a href="/message/' + json.data[i][0] + '>View message</a>';
                //        //}

                //        //columnNames = Object.keys(json.data[0]);
                //        //for (var i in columnNames) {
                //        //    {
                //        //        if (!columnNames[i].endsWith('ID'))
                //        //            columns.push({
                //        //                data: columnNames[i]//,
                //        //                //class: "center",
                //        //                //title: columnNames[i]
                //        //            });
                //        //    }
                //        //}
                //        //let obj = [
                //        //    {
                //        //        "data": "StudentID",
                //        //        //"title": 'StudentID',
                //        //        "render": function (data) {
                //        //            return `<a class='btn btn-default btn-sm' onclick=PopupForm('${controlname}/StoreOrEdit?id=${data}&actions=edit')><i class='fa fa-pencil'></i>Edit</a> <a class='btn btn-danger btn-sm' style='margin-left:5px' onclick=Delete('${data}')><i class='fa fa-trash'></i>Delete</a>`;
                //        //        },
                //        //        "orderable": false,
                //        //        "searchable": false,
                //        //        "width": "150px"
                //        //    }
                //        //];
                //        //columns.push(obj);

                //        return json.data;
                //        //jsonObj = $.parseJSON(json.data);
                //        //return jsonObj.data;
                //    }
                //},  
                columns: columns,
                data: _data1,//_data,
                aoColumns: aocolumns,
              
                //"columns": [{ "data": "StudentID" },
                //    //{ "data": "Name" },
                //    //{ "data": "Department" },
                //    //{ "data": "Semester" },
                //    //{ "data": "Age" },
                //    //{ "data": "Fees" },
                //    //{
                //    //    "data": "StudentID", "render": function (data) {
                //    //        return `<a class='btn btn-default btn-sm' onclick=PopupForm('${controlname}/StoreOrEdit?id=${data}&actions=edit')><i class='fa fa-pencil'></i>Edit</a> <a class='btn btn-danger btn-sm' style='margin-left:5px' onclick=Delete('${data}')><i class='fa fa-trash'></i>Delete</a>`;
                //    //    },
                //    //    "orderable": false,
                //    //    "searchable": false,
                //    //    "width": "150px"
                //    //}
                //],
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
                }, initComplete: function () {
                    console.log("The Table has been initialized!")
                },
                dom: "<'row'<'col-sm-2'f><'col-sm-10 text-right'B>>" +
                    "<'row'<'col-sm-12'tr>>" +
                    "<'row'<'col-sm-2'l><'col-sm-2'i><'col-sm-4'><'col-sm-4'p>>",
                buttons: [
                    {
                        text: "<a class='btn btn-primary btn-sm' onclick=PopupForm('Student/StoreOrEdit?id=&actions=Add')><i class='fa fa-pencil'></i>Add New</a>",
                        attr: {
                            id: 'btn-add-review'
                        },
                        action: function (e, dt, node, config) {
                            alert('Button activated');
                        },
                        initComplete: function () {
                            console.log('Test2');
                            var btns = $('#btn-add-review');
                            btns.css("border", "none");
                        },
                        init: function (dt, node, config) {
                            console.log('Test');
                            $(node).css("background-color", "transparent");
                            $(node).css("border", "none");
                        }
                    }
                ]

            });
        }
    });

  
    
    //$('.input-daterange').datepicker({
    //    todayBtn: 'linked',
    //    format: "yyyy-mm-dd",
    //    autoclose: true
    //});

    //dataTable.columns = columns;
    //setInterval(function () {
    //    dataTable.ajax.reload();
    //}, 10000);
}
function PopupForm(url) {

    var formDiv = $('<div/>');
    $.get(url)
        .done(function (response) {

            formDiv.html(response);

            Popup = formDiv.dialog({

                autoOpen: true,
                resizable: false,
                title: 'Fill Student Details',
                height: 500,
                width: 700,
                modal: true,
                close: function () {

                    Popup.dialog('destroy').remove();
                }

            });

        });
}

function SubmitForm(form) {

    $.validator.unobtrusive.parse(form);
    if ($(form).valid()) {

        $.ajax({
            type: "POST",
            url: form.action,
            headers: { '__RequestVerificationToken': token },
            data: $(form).serialize(),
            success: function (data) {

                if (data.success) {

                    Popup.dialog('close');
                    dataTable.ajax.reload();

                    $.notify(data.message, {
                        globalPosition: "top center",
                        className: "success"
                    })
                }
                else {
                    Popup.dialog('close');
                    Swal.fire(
                        "查詢作業失敗", //標題 
                        data.message, //訊息內容(可省略)
                        "error" //圖示(可省略) success/info/warning/error/question
                        //圖示範例：https://sweetalert2.github.io/#icons
                    );
                }
            }
        });
    }

    return false;

}

function Delete(id) {
    //Swal.fire({
    //    title: '请输入密码！',
    //    input: 'password',
    //    showCancelButton: true,
    //    confirmButtonText: '确定',
    //    cancelButtonText: '取消',
    //    inputValidator: (value) => {
    //        return new Promise(function (resolve) {
    //            if (value === "0") { // 密码为0
    //                alert("执行你想要的操作！")
    //                resolve()
    //            } else {
    //                swal({
    //                    title: "密码错误，请联系管理员！",
    //                    type: "error"
    //                })
    //            }
    //        })
    //    }
    //})
    Swal.fire({
        icon: 'info',
        //position: 'top-end',
        title: "操作確認",
        text: "請點選你想按的按鈕",
        showCancelButton: true,

        cancelButtonText: '取消',
        confirmButtonText: '确定',
        focusCancel: false, // 是否聚焦 取消按鈕
        reverseButtons: true
    }).then(function (result) {
        try {
            if (result.value) {
                $.ajax({

                    type: "POST",
                    url: "Student/Delete/" + id,
                    headers: { '__RequestVerificationToken': token },
                    success: function (data) {

                        if (data.success) {

                            dataTable.ajax.reload();

                            //$.notify(data.message, {
                            //    globalPosition: "top center",
                            //    className: "success"
                            //})
                            //Swal.fire("您選擇了Cancel");
                            Swal.fire({

                                title: "Deleted!",
                                text: "Your file was successfully deleted!",
                                type: "success"
                            })
                        }
                        else {
                            Swal.fire({
                                title: "Oops!",
                                text: "We couldn't connect to the server!",
                                type: "error"
                            })
                            //swal("Oops", "We couldn't connect to the server!", "error");
                        }
                    }

                });
            }
            else {
                //Swal.fire("您選擇了Cancel");
                //type: "error";
            }
        } catch (e) {
            alert(e);
        }
    });
    //notyConfirm('確定?', 'xx', 'xx');
    //alert(Resources.test);
    //if (confirm(Resources.test)) {

    //    $.ajax({

    //        type: "POST",
    //        url: "Student/Delete/" + id,
    //        success: function (data) {

    //            if (data.success) {

    //                dataTable.ajax.reload();

    //                $.notify(data.message, {
    //                    globalPosition: "top center",
    //                    className: "success"
    //                })

    //            }
    //        }

    //    });
    //}
}

using (var progress = UserDialogs.Instance.Progress(
					"Long Load...",
					// this will cancel the actual http call
					() => cts.Cancel(),
					"Cancel"))
				{
                    int j = 1;
                    //               ls.ForEach( f =>
                    //               {

                    //                   Task.Delay(TimeSpan.FromMilliseconds(6000));
                    //                   progress.PercentComplete = j++;

                    //               });

                    for (int i = 0; i < ls.Count; i++) // loop untill 50% then increase sleeping thread time
                    {
                        await Task.Delay(TimeSpan.FromMilliseconds(60));
                        progress.PercentComplete = j++;
                    }
                }
