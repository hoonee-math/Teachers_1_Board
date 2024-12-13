<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>맘스티쳐</title>

  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
      display: flex;
      flex-direction: column;
    }

    .main-header {
      display: none;
    }

    .menu {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 20px;
      background-color: #FFE4E1;
    }

    .menu .logo-container {
      display: flex;
      align-items: center;
      padding: 10px;
      background-color: #FFE4E1;
      border-radius: 5px;
    }

    .menu .logo {
      width: 40px;
      height: auto;
    }

    .menu .logo-text {
      margin-left: 10px;
      font-size: 20px;
      font-weight: bold;
      color: #FF69B4;
    }

    .menu .left-section {
      display: flex;
      gap: 5px; 
      margin-right: auto;
      align-items: center;
    }

    .menu .left-section div {
      cursor: pointer;
      padding: 10px 15px;
      border: 1px solid #FFB6C1;
      border-radius: 5px;
      background-color: #ffffff;
      color: #FF69B4;
      text-align: center;
      font-weight: bold;
      transition: background-color 0.3s;
    }

    .menu .left-section div:hover {
      background-color: #FFB6C1;
      color: #ffffff;
    }

    .search-container {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      flex: 1;
      gap: 10px;
    }

    .search-box {
      display: flex;
      align-items: center;
      border: 1px solid #FFB6C1;
      border-radius: 5px;
      background-color: #ffffff;
      padding: 5px 30px;
      width: 350px;
      margin-left: 20px;
    }

    .search-box input {
      flex: 1;
      border: none;
      outline: none;
      padding: 5px;
      font-size: 16px;
    }

    .search-button {
      margin-left: 1px;
      padding: 5px 15px;
      background-color: #FF69B4;
      color: #ffffff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
      transition: background-color 0.3s;
    }

    .search-button:hover {
      background-color: #FFB6C1;
    }
  </style>
</head>
<body>
  <div class="menu">
    <div class="logo-container">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" class="logo">
        <ellipse cx="150" cy="100" rx="140" ry="80" fill="#FFE4E1"/>
        <path d="M100 50 L200 50 C210 50 210 150 200 150 L100 150 C90 150 90 50 100 50" fill="#FFF5EE"/>
        <path d="M110 60 L190 60 M110 80 L190 80 M110 100 L190 100 M110 120 L190 120 M110 140 L190 140" stroke="#FFB6C1" stroke-width="2"/>
        <path d="M180 40 C180 40 175 35 170 40 C165 45 170 55 170 55 L180 65 L190 55 C190 55 195 45 190 40 C185 35 180 40 180 40" fill="#FF69B4"/>
        <path d="M85 90 C85 80 95 70 105 70 C115 70 125 80 125 90 M95 95 C95 85 105 75 115 75" stroke="#FF69B4" stroke-width="3" fill="none" stroke-linecap="round"/>
        <path d="M70 110 L80 110 M90 110 L100 110 M110 110 L120 110" stroke="#FFB6C1" stroke-width="2" stroke-dasharray="2,3"/>
      </svg>
      <span class="logo-text">맘스티쳐</span>
    </div>
    <div class="left-section">
      <div id="grade-board">학년별 게시판</div>
      <div>지역별 게시판</div>
      <div>학교검색</div>
    </div>
    <div class="search-container">
      <div class="search-box">
        <input type="text" placeholder="검색어를 입력하세요">
      </div>
      <button class="search-button">검색</button>
    </div>
  </div>

  <script>
    const gradeBoard = document.getElementById('grade-board');

    gradeBoard.addEventListener('mouseover', () => {
      
    });

    gradeBoard.addEventListener('mouseout', () => {
      
    });
  </script>