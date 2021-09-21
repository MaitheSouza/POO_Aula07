<%-- 
    Document   : index
    Created on : 20 de set. de 2021, 22:46:21
    Author     : MaitheSouza
--%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
    String nome = String.valueOf(session.getAttribute("nome"));
    String senha = String.valueOf(session.getAttribute("senha"));
    Boolean sessionActive = nome != "null" && senha != "null";
    
    String nomeRequest = String.valueOf(request.getParameter("nome"));
    String senhaRequest = String.valueOf(request.getParameter("senha"));
    Boolean isValid = nomeRequest != "null" && senhaRequest != "null";
    
    String listaNumeros = String.valueOf(session.getAttribute(nomeRequest == "null" ? nome : nomeRequest));
    List<String> listagemDaSorte = new ArrayList();
    
    if(listaNumeros != "null"){
        listagemDaSorte = Arrays.asList(listaNumeros.replace("[", "").replace("]", "").split(",",-1));
    }
    
    if (isValid) {
        session.setAttribute("nome", nomeRequest);
        session.setAttribute("senha", senhaRequest);
        if (listaNumeros == "null") {
            Random gerador = new Random();
            List<Integer> list = new ArrayList();
            for (Integer i = 0; i < 6; i++) {
                list.add(1+ gerador.nextInt(59));
            }
            session.setAttribute(nomeRequest, String.valueOf(list));
        }
        response.sendRedirect("index.jsp");
    }
    
    String logout = String.valueOf(request.getParameter("logout"));
    if (logout != "null") {
        session.removeAttribute("name");
        session.removeAttribute("senha");
        response.sendRedirect("index.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MAITHESOUZAAPP</title>
        <style>
            form {
                display: flex;
                flex-flow: column nowrap;
                gap: 1rem;
                width: 100%;
            }
            form div {
                display: flex;
                flex-flow: column nowrap;
                width: 100%;
            }
            form :not(input[type="submit"]) input {
                border-radius: 0.5rem;
                padding: 0.4rem 1rem;
                border: 1px solid #FF729F;
                margin: 0.2rem 0;
            }
            form input[type="submit"] {
                background: #FF729F; 
                padding: 0.4rem 1rem;
                color: white;
                border-radius: 0.5rem;
                margin: auto;
                cursor: pointer;
            }
            table {
                border-collapse: collapse;
                width: 100%;
            }
            table td, table th {
                border: 1px solid #ddd;
                padding: 8px;
            }
            table tbody th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: white;
                color: black;
            }
            table thead th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: center;
                background-color: #FF729F;
                color: white;
            }
        </style>
    </head>
    <body>
        <%@include file="WEB-INF/header.jspf" %>
        <div class='container'>
            <%if (!sessionActive) {%>
            <form action="index.jsp">
                <div>
                    <label for='nome'>Nome</label>
                    <input required type='text' id='nome' name='nome' placeholder='Seu nome de usuário'/>
                </div>
                <div>
                    <label for='senha'>Senha</label>
                    <input required type='password' name='senha' id='senha' placeholder='Sua senha' />
                </div>
                <input type='submit' value='Fazer login' />
            </form>
            <%} else {%>
            Olá <%=nome%>
                <table>
                    <thead>
                        <tr>
                            <th>Posição</th>
                            <th>Número</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < listagemDaSorte.size(); i++) { %>
                            <tr>
                                <th><%=i+1%></th>
                                <th><%=listagemDaSorte.get(i)%></th>
                            </tr>
                        <%}%>
                    </tbody>
                </table>
            <%}%>
        </div>
    </body>
</html>