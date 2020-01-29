<!doctype html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <style>
        .logo {
            margin-left: 100px;
            background-image: url("../img/IT20.svg");
            background-repeat: no-repeat;
            width: 180px;
            height: 100px;
            float: left;
            margin-top: 25px;
        }
        .it20 {
            width: 800px;
            outline: 1px solid red;
            margin: 0 auto;
            overflow: hidden;
            margin-top: 30px;
            color: #0000cc;
            border-bottom: 1px solid #000000;
        }
        .text {
            float: left;
            width: 400px;
            margin-left: 40px;
        }
        .mainText {
            text-align: center;
            margin-top: 5px;
        }
        .boldIT20 {
            margin-top: -20px;
        }
        .infoIT20 {
            overflow: hidden;
        }
        .email {
            float: left;
            margin-left: 108px;
        }
        .url {
            float: left;
        }
        .url p,
        .email p {
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <div class="it20">
        <div class="logo"></div>
        <div class="text">
            <div class="mainText">
                <p>Общество с ограниченной ответственностью</p>
                <p class="boldIT20"><b>«IT 2.0»</b></p>
            </div>
            <div class="infoIT20">
                <div class="url">
                    <p>www.aiti20.com</p>
                    <p>+38 (097) 535-11-29 </p>
                </div>
                <div class="email">
                    <p>mail@aiti20.com</p>
                    <p>+38 (095) 900-38-00</p>
                </div>
            </div>
        </div>
        <main class="py-4">
            @yield('content')
        </main>
    </div>

</body>

</html>