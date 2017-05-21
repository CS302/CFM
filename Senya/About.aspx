<%@ Page Title="Обследование" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Senya.About" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>Подключите прибор к компьютеру, введите ID пациента.</h2>
    </hgroup>

    <article>
        <ol class="round">
            <li class="one"> 
                <p>   
                    Информация о пациенте
                </p>
                <br/>
            </li>
        </ol>
<%--Таблица с информацией о пациенте --%>        
        <table>
            <tr>
                <td>
                    <asp:Label runat="server" Text="ID пациента:" Width="100"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_pID" Width="150"/>
                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="_TB_pID" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ValidationGroup="RegisterUserValidationGroup"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:Button runat="server" ID="_BTN_ok" Text="ОК" ForeColor="Green" ToolTip="Работать с этим пациентом." OnClick="_BTN_ok_Click"/>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:Label runat="server" Text="Имя:" Width="100"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_Name" Width="150" Enabled="false"/>
                </td>

                <td>
                    <asp:Label runat="server" Text="Фамилия:" Width="100"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_Surname" Width="150" Enabled="false"/>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:Label runat="server" Text="Компания:" Width="100"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_Company" Width="150" Enabled="false"/>
                </td>

                <td>
                    <asp:Label runat="server" Text="Должность:" Width="100"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_Position" Width="150" Enabled="false"/>
                </td>
            </tr>
        </table>

        <ol class="round">
            <li class="two"> 
                <p>   
                    Обследование:
                </p>
                <br/>
            </li>
        </ol>
        <asp:Button runat="server" ID="_BTN_Start" Text="Начать обследование" ForeColor="Green" ToolTip="Выполнить запуск процедуры на приборе." OnClick="_BTN_Start_Click"/>
        <br/>
        <p>
            <asp:Label runat="server" ID="_LBL_results" Text="Обследование не проведено. Нажмите на кнопку 'Начать обследование'"/>
        </p>
<%--Таблица с результатами измерений --%>
        <table border="0">
            <tr>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m1" Width="85" Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m2" Width="85" Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m3" Width="85" Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m4" Width="85" Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m5" Width="85" Enabled="false"/>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m6" Width="85" Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m7" Width="85" Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m8" Width="85" Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m9" Width="85" Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_m10" Width="85" Enabled="false"/>
                </td>
            </tr>
        </table>      

        <ol class="round">
            <li class="three"> 
                <p>   
                    Заключение и результаты экспертизы:
                </p>
                <br/>
            </li>
        </ol>
        <table>
            <tr>
                <td>
                    <asp:Label runat="server" ID="_LBL_res" Text="Обследование пройдено" Font-Bold="true" Font-Size="X-Large"/>
                </td>
                <td>
                    <asp:ImageButton runat="server" ID="_IMGBTN_OK" Enabled="false" Visible="false"/>
                </td>
            </tr>
            <tr>
                <td>
                    Оценки числовых характеристик:
                </td>
            </tr>
        </table>
        <br/>
        <br/>
<%--Таблица с заключением --%>

        <table border="0">
            <tr>
                <td>
                    <asp:Label runat="server" Text="Оценка МО:" Width="100"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_ev" Enabled="false" Width="85"/>
                </td>
                <td>
                    <asp:Label runat="server" Text="Обычное значение:" Width="150"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_ev_ok" Enabled="false" Width="85"/>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" Text="Оценка СКО:" Width="100"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_sd" Enabled="false" Width="85"/>
                </td>
                <td>
                    <asp:Label runat="server" Text="Относительная ошибка:" Width="150"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="_TB_sd_ok" Enabled="false" Width="85"/>
                </td>
            </tr>
        </table>

    </article>

    <aside>
        <h3>Навигация</h3>
        <p>        
            
        </p>
        <ul>
            <li><a runat="server" href="~/">Начало работы</a></li>
            <li><a runat="server" href="~/About">Обследование</a></li>
            <li><a runat="server" href="~/Contact">История посещений</a></li>
        </ul>
    </aside>
</asp:Content>