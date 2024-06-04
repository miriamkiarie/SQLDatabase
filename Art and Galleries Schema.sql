Create database ArtandGalleriesDB;
Use  ArtandGalleriesDB;

Create Table Gallery (
 GalleryNum INT primary key
 Name Varchar (25)
 Phone INT
 Hours TIME
  Intro Varchar (30));
  
Create Table Loacations (
 ID INT primary key
 Country Varchar (20)
 State VARCHAR (20)
 CitY varchar (20)
 Street Varchar (25)
  ZipCode int );
  
 Create Table Drawings(
 Drawingnum int primary key
 Title Varchar ( 20)
 Size INT
 Material Varchar(25)
 Date Date );
 
 Create table Artists( 
 ArtistNum int primary key
 Name varchar
 Phone INT
 Birthday DATE
 Email Varchar (60));
 
Create Table BioStatements( 
 Citizenship Varchar(30) 
 Education  Varchar(30)
 Experience Varchar (30)
 MasterPiece dec);

