<%@ Page Title="История посещений" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Senya.Contact" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>Сегодняшнее обследование.</h2>
    </hgroup>
    <article>
    <section class="contact">
        <header>
            <h3>Для записей:</h3>
        </header>
        <p>
            <span class="label">С прошлых посещений:</span>
        </p>
        <p>
            <asp:TextBox runat="server" ID="_TB_Last" TextMode="MultiLine" Enabled="false" Width="500" Font-Size="Larger"/>
        </p>
        <p>
            <span class="label">Текущее посещение:</span>
        </p>
        <p>
            <asp:TextBox runat="server" ID="_TB_Current" TextMode="MultiLine" Enabled="true" Width="500" Font-Size="Larger"/>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Назначение больничного:</h3>
        </header>
        <p>
            <span class="label">Больничный не нужен:</span>
            <asp:CheckBox runat="server" Enabled="true" ID="_ChB_Susp" Font-Size="Large" BackColor="Green"/>
        </p>
        <p>
            <span class="label">Больничный с:</span>
        </p>
        <p>
            <asp:TextBox runat="server" ID="_TB_FirstDate" Font-Size="Larger" TextMode="Date" />
        </p>
        <p>
            <span class="label">по:</span>
        </p>
        <p>
            <asp:TextBox runat="server" ID="_TB_SecondDate" Font-Size="Larger" TextMode="Date" />
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Завершение обследования:</h3>
        </header>
        <p>
            <asp:Button runat="server" ID="_BTN_save" Text="Сохранить" ForeColor="Green" ToolTip="Сохранение результатов в БД." OnClick="_BTN_save_Click"/>
        </p>
    </section>
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