<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Senya._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1>Измерение КЧСМ.</h1>
                <h2>Быстрый, качественный и точный анализ состояния человека.</h2>
            </hgroup>
            <p>
                
            </p>
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h3>Данный web-сервис предоставляет:</h3>
    <ol class="round">
        <li class="one">
            <h5>Программное обеспечение</h5>
            Все, что необходимо для проведения обследования и ведения истории болезни есть на этом WEB-сайте.
        </li>
        <li class="two">
            <h5>Анализ результатов</h5>
            Все рассчеты и из обработка происходят моментально и автоматически.
        </li>
        <li class="three">
            <h5>Статистика по каждому пациенту</h5>
            Подробная информация о состоянии здоровья каждого пациента автоматически подгружается и доступна для просмотра.
        </li>
    </ol>
</asp:Content>
