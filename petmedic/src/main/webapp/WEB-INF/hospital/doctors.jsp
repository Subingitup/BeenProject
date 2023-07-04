<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        
        #qwerqwer {
            margin: 0 auto;
            width: 70%;
        }
        
        .doc-item {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
            border: 1px solid #ccc;
        }
        
        .doc-image {
            flex-basis: 200px;
            max-width: 100%;
            margin-bottom: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            border-right: 1px solid #ccc;
        }

        .doc-image img {
            width: 100%;
            height: auto;
            object-fit: contain;
        }     
        
        .doc-details {
            flex-basis: auto;
            text-align: center;
        }
        
        .doc-name {
            font-weight: bold;
        }
        
        @media only screen and (max-width: 768px) {
            .doc-image {
                border-right: none;
            }
            
            #container {
                width: 100%;
            }
            
            .doc-item {
                margin-bottom: 10px;
            }
            .doc-details {
                margin: auto;
            }
        }
        
        @media only screen and (min-width: 768px) {
            #qwerqwer {
                width: 100%;
            }
            
            .doc-details {
                margin: auto;
            }
        }
    </style>
</head>
<body>
    <div class="container" id="">
        <c:choose>
            <c:when test="${empty docList}">
                <div class="col-md-12 text-center">
                    등록된 의사가 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${docList}" var="doc" varStatus="status">
                    <div class="doc-item">
                        <div class="doc-image">
                            <c:choose>
                                <c:when test="${empty doc.doc_filename}">
                                    <img src="../img/doc.png" alt="docDefault" title="docDefault">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/img/${doc.doc_filename}">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="doc-details">
                            <p class="doc-name">${doc.doc_name} 수의사</p>
                            <p>${doc.doc_info}</p>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>