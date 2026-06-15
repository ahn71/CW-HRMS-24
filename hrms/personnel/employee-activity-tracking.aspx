<%@ Page Title="Employee Activity Tracking" Language="C#" MasterPageFile="~/hrms/HRMS.Master" AutoEventWireup="true" CodeBehind="employee-activity-tracking.aspx.cs" Inherits="SigmaERP.hrms.personnel.employee_activity_tracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .activity-page {
            padding: 12px 0 24px;
        }

        .activity-title {
            color: #111827;
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .activity-subtitle {
            color: #6b7280;
            font-size: 13px;
            margin-bottom: 0;
        }

        .filter-card,
        .summary-card,
        .map-card,
        .timeline-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            box-shadow: 0 8px 22px rgba(15, 23, 42, 0.04);
        }

        .filter-card {
            padding: 18px;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 12px;
            margin-bottom: 16px;
        }

        .summary-card {
            padding: 14px 16px;
        }

        .summary-label {
            color: #6b7280;
            font-size: 12px;
            margin-bottom: 5px;
        }

        .summary-value {
            color: #111827;
            font-size: 18px;
            font-weight: 600;
            overflow-wrap: anywhere;
        }

        .map-card {
            padding: 12px;
        }

        #activityMap {
            height: 560px;
            min-height: 420px;
            width: 100%;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            background: #eef2f7;
        }

        .map-empty {
            align-items: center;
            color: #6b7280;
            display: flex;
            font-size: 15px;
            height: 420px;
            justify-content: center;
            text-align: center;
        }

        .timeline-card {
            padding: 16px;
        }

        .activity-table th {
            color: #374151;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .activity-table td {
            color: #111827;
            font-size: 13px;
            vertical-align: middle;
        }

        .point-badge {
            align-items: center;
            background: #e0f2fe;
            border-radius: 999px;
            color: #075985;
            display: inline-flex;
            font-size: 12px;
            font-weight: 600;
            height: 24px;
            justify-content: center;
            min-width: 24px;
            padding: 0 8px;
        }

        .message-box {
            border-radius: 8px;
            margin-bottom: 14px;
            padding: 12px 14px;
        }

        @media (max-width: 991px) {
            .summary-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 575px) {
            .summary-grid {
                grid-template-columns: 1fr;
            }

            #activityMap {
                height: 420px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="activity-page">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12 mb-20">
                    <h4 class="activity-title">Employee Activity Tracking</h4>
                    <p class="activity-subtitle">Filter by employee and time duration to view movement points on OpenStreetMap.</p>
                </div>
            </div>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message-box alert-warning">
                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
            </asp:Panel>

            <div class="filter-card mb-20">
                <div class="row g-3 align-items-end">
                    <div class="col-lg-3 col-md-6">
                        <label class="form-label mb-1" for="<%= txtEmployee.ClientID %>">Employee ID / Card No</label>
                        <asp:TextBox ID="txtEmployee" runat="server" CssClass="form-control" placeholder="Type employee id or card no"></asp:TextBox>
                    </div>
                    <div class="col-lg-2 col-md-6">
                        <label class="form-label mb-1" for="<%= txtFromDate.ClientID %>">From Date</label>
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-lg-2 col-md-6">
                        <label class="form-label mb-1" for="<%= txtFromTime.ClientID %>">From Time</label>
                        <asp:TextBox ID="txtFromTime" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                    </div>
                    <div class="col-lg-2 col-md-6">
                        <label class="form-label mb-1" for="<%= txtToDate.ClientID %>">To Date</label>
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-lg-2 col-md-6">
                        <label class="form-label mb-1" for="<%= txtToTime.ClientID %>">To Time</label>
                        <asp:TextBox ID="txtToTime" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                    </div>
                    <div class="col-lg-1 col-md-6">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-sm w-100" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <div class="summary-grid">
                <div class="summary-card">
                    <div class="summary-label">Employee</div>
                    <div class="summary-value"><asp:Literal ID="litEmployeeName" runat="server" Text="-"></asp:Literal></div>
                </div>
                <div class="summary-card">
                    <div class="summary-label">Total Points</div>
                    <div class="summary-value"><asp:Literal ID="litTotalPoints" runat="server" Text="0"></asp:Literal></div>
                </div>
                <div class="summary-card">
                    <div class="summary-label">First Seen</div>
                    <div class="summary-value"><asp:Literal ID="litFirstSeen" runat="server" Text="-"></asp:Literal></div>
                </div>
                <div class="summary-card">
                    <div class="summary-label">Last Seen</div>
                    <div class="summary-value"><asp:Literal ID="litLastSeen" runat="server" Text="-"></asp:Literal></div>
                </div>
            </div>

            <div class="map-card mb-20">
                <div id="activityMap"></div>
            </div>

            <div class="timeline-card">
                <div class="table-responsive">
                    <asp:GridView ID="gvActivity" runat="server" AutoGenerateColumns="false" CssClass="table table-hover activity-table mb-0" GridLines="None" EmptyDataText="No movement data found for this filter.">
                        <Columns>
                            <asp:TemplateField HeaderText="#">
                                <ItemTemplate>
                                    <span class="point-badge"><%# Container.DataItemIndex + 1 %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ActivityTimeText" HeaderText="Activity Time" />
                            <asp:BoundField DataField="LatitudeText" HeaderText="Latitude" />
                            <asp:BoundField DataField="LongitudeText" HeaderText="Longitude" />
                            <asp:BoundField DataField="EmpCardNo" HeaderText="Card No" />
                            <asp:BoundField DataField="DptName" HeaderText="Department" />
                            <asp:BoundField DataField="DsgName" HeaderText="Designation" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <script src="/hrms/assets/vendor_assets/js/leaflet.js"></script>
    <script>
        var activityPoints = <%= MapPointsJson %>;
        var activityMap;

        function initActivityMap() {
            var mapElement = document.getElementById('activityMap');
            if (!mapElement) {
                return;
            }

            if (!activityPoints || activityPoints.length === 0) {
                mapElement.className = 'map-empty';
                mapElement.innerHTML = 'No map points available for this filter.';
                return;
            }

            activityMap = L.map('activityMap', {
                scrollWheelZoom: true
            });

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 19,
                attribution: '&copy; OpenStreetMap contributors'
            }).addTo(activityMap);

            var latLngs = [];
            for (var i = 0; i < activityPoints.length; i++) {
                var point = activityPoints[i];
                var latLng = [point.Latitude, point.Longitude];
                latLngs.push(latLng);

                var marker = L.marker(latLng).addTo(activityMap);
                marker.bindPopup(
                    '<strong>Point ' + (i + 1) + '</strong><br />' +
                    point.ActivityTime + '<br />' +
                    'Lat: ' + point.Latitude + '<br />' +
                    'Long: ' + point.Longitude
                );
            }

            if (latLngs.length > 1) {
                L.polyline(latLngs, {
                    color: '#2563eb',
                    weight: 4,
                    opacity: 0.85
                }).addTo(activityMap);
                activityMap.fitBounds(latLngs, { padding: [30, 30] });
            } else {
                activityMap.setView(latLngs[0], 16);
            }
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initActivityMap);
        } else {
            initActivityMap();
        }
    </script>
</asp:Content>
