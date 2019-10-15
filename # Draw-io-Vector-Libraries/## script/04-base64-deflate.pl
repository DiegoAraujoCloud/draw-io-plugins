#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;
use Compress::Zlib;

open FOO,"basemodel_url_encoded";
my $code = join('',<FOO>);
close FOO;

# my $code = '<mxGraphModel><root><mxCell id="0"/><mxCell id="1" parent="0"/><mxCell id="2" value="" style="shape=image;editableCssRules=.*;verticalLabelPosition=bottom;verticalAlign=top;imageAspect=0;aspect=fixed;image=data:image/svg+xml,PHN2ZyB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyIgeG1sbnM6c3ZnPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0ic3ZnMjc3NjkyIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDUyLjMgNTIuMyIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNTIuMyA1Mi4zOyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+JiN4YTs8c3R5bGUgdHlwZT0idGV4dC9jc3MiPiYjeGE7CS5zdDB7ZmlsbDojNTg1OTVCO30mI3hhOzwvc3R5bGU+JiN4YTs8ZyBpZD0ibGF5ZXIxIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgzMy4wMzk2MjksLTEzOS42MDYzMykiPiYjeGE7CTxnIGlkPSJnNDY0Ny03IiB0cmFuc2Zvcm09Im1hdHJpeCgyLjIwMDY1OTMsMCwwLDIuMjAwNjU5MywtODEuOTU1NzA4LDY5LjgxMTkyOSkiPiYjeGE7CQk8ZyBpZD0iZzQwMS01IiB0cmFuc2Zvcm09Im1hdHJpeCgwLjM1Mjc3Nzc3LDAsMCwtMC4zNTI3Nzc3NywyNC44NDkzNTEsMzQuNTU0MzEpIj4mI3hhOwkJCTxwYXRoIGlkPSJwYXRoNDAzLTIiIGNsYXNzPSJzdDAiIGQ9Ik0xMy42LTE0LjhjMC4xLDAuNSwwLjUsMC45LDAuOSwxbDMuMywxbDEuNS0xLjFsLTEuMi0xLjZjLTAuMi0wLjItMC4xLTAuNSwwLTAuN2w1LjgtNi40ICAgICBjLTQuMywwLjEtNy4yLDAuNC04LjIsMC42djMuOGMwLDAuMy0wLjIsMC41LTAuNSwwLjVjLTAuMywwLTAuNS0wLjItMC41LTAuNXYtMy4xbC0yLjUsMC40TDEzLjYtMTQuOHogTTM3LjgtMTQuN2wxLjQtNiAgICAgbC0yLjUtMC40aDB2My4xYzAsMC4zLTAuMiwwLjUtMC41LDAuNWMtMC4zLDAtMC41LTAuMi0wLjUtMC41di0zLjhjLTEuMS0wLjMtMy45LTAuNi04LjMtMC42bDUuOCw2LjRjMC4yLDAuMiwwLjIsMC41LDAsMC43ICAgICBMMzItMTMuOWwxLjYsMS4xbDMuMy0xQzM3LjMtMTMuOSwzNy43LTE0LjMsMzcuOC0xNC43IE0yNS4zLTE2bC0wLjYtMi44TDIyLjMtMTNsMi40LTEuNkwyNC41LTE1TDI1LjMtMTZ6IE0yNi44LTE4LjhMMjYuMi0xNiAgICAgbDAuOCwxbC0wLjMsMC40bDIuNCwxLjZMMjYuOC0xOC44eiBNMzAuOC0xMS45bDEuNS0wLjRsLTEuMy0wLjljLTAuMS0wLjEtMC4yLTAuMi0wLjItMC4zczAtMC4zLDAuMS0wLjRsMS4zLTEuN2wtNS4yLTUuNyAgICAgTDMwLjgtMTEuOUwzMC44LTExLjl6IE0yMC41LTEzLjNsLTEuMywwLjlsMS41LDAuNGwwLjEtMC4xbDMuOS05LjZsLTUuNCw1LjlsMS4zLDEuN2MwLjEsMC4xLDAuMSwwLjMsMC4xLDAuNCAgICAgUzIwLjYtMTMuNCwyMC41LTEzLjMgTTEwLjgtMjIuNmwzLjEtMC41YzAuNi0wLjcsMi44LTEuNSwxMS44LTEuNXMxMS4zLDAuOCwxMS44LDEuNWwzLjEsMC41YzAuMywwLDAuNSwwLjIsMC43LDAuNCAgICAgYzAuMiwwLjIsMC4yLDAuNSwwLjIsMC44bC0xLjYsNy4yYy0wLjMsMS4yLTEuMiwyLjEtMi40LDIuNWwtNi42LDEuOWMtMC4zLDAuMS0wLjYsMC0wLjktMC4xbC00LjMtMi44bC00LjMsMi44ICAgICBjLTAuMywwLjItMC42LDAuMi0wLjksMC4xTDE0LTExLjdjLTEuMi0wLjQtMi0xLjMtMi40LTIuNUwxMC0yMS40Yy0wLjEtMC4zLDAtMC42LDAuMi0wLjhDMTAuMy0yMi40LDEwLjUtMjIuNiwxMC44LTIyLjYiLz4mI3hhOwkJPC9nPiYjeGE7CQk8ZyBpZD0iZzQwNS00IiB0cmFuc2Zvcm09Im1hdHJpeCgwLjM1Mjc3Nzc3LDAsMCwtMC4zNTI3Nzc3NywyNS43NTkwMjMsMzIuMjUxOCkiPiYjeGE7CQkJPHBhdGggaWQ9InBhdGg0MDctNSIgY2xhc3M9InN0MCIgZD0iTTE4LjQtMi44YzAuMiwwLjMsMC41LDAuNCwwLjgsMC40aDBjMC4zLDAsMC43LDAuMSwwLjksMC40YzAsMC4xLDEuMiwxLjQsMy4yLDEuNCAgICAgYzAuNSwwLDEtMC4xLDEuNS0wLjJjNC0xLjIsMy40LTUsMy4zLTUuNGMwLTAuMSwwLTAuMi0wLjEtMC4zYy0xLjIsMC4xLTMuMywxLjItNC42LDMuMWMtMC41LDAuNi0xLDEtMS42LDEuMSAgICAgYy0xLDAuMS0xLjktMC41LTIuNS0xQzE5LTMuNywxOC44LTQsMTguNi00LjRDMTguNC01LDE4LjItNS41LDE4LTUuOEMxNy43LTMuOSwxOC4xLTMuMSwxOC40LTIuOCBNMjguNy05LjYgICAgIGMtMC4xLTAuNC0wLjMtMC43LTAuNC0wLjljLTAuMS0wLjEtMC4xLTAuMS0wLjItMC4yYy0wLjMtMC4xLTAuNS0wLjQtMC41LTAuN2MtMC4zLTEtMC45LTIuMS0xLjgtMy4xYy0wLjgtMC45LTEuNS0xLjItMi41LTEuMiAgICAgdi0xLjFsMCwxLjFjLTEsMC0xLjcsMC4zLTIuNSwxLjJjLTAuOSwxLTEuNSwyLTEuOCwzLjFjLTAuMSwwLjMtMC4zLDAuNS0wLjUsMC43YzAsMC0wLjEsMC4xLTAuMiwwLjJjLTAuMSwwLjEtMC4yLDAuMy0wLjMsMC41ICAgICBjLTAuMiwwLjQtMC4zLDEtMC4zLDEuNGMwLDAuMSwwLDAuMSwwLDAuMmMwLDAuMiwwLjEsMC4zLDAuMSwwLjRjMCwwLDAsMCwwLjEsMC4xYzAuMywwLjIsMC41LDAuNSwwLjYsMC44ICAgICBjMC41LDAuNCwxLDEuMywxLjQsMi40YzAuMSwwLjIsMC4yLDAuNCwwLjMsMC41YzAuMywwLjMsMSwwLjgsMS43LDAuOGMwLjMsMCwwLjYtMC4yLDAuOS0wLjZjMS41LTIuMSw0LTMuNiw1LjctMy42ICAgICBjMC4xLTAuMSwwLjItMC4yLDAuMy0wLjNjMC4xLDAsMC4xLTAuMSwwLjEtMC4xYzAuMS0wLjEsMC4xLTAuMiwwLjEtMC40YzAsMCwwLDAsMCwwYzAtMC4xLDAtMC4xLDAtMC4yICAgICBDMjguOS04LjksMjguOC05LjMsMjguNy05LjYgTTE2LjUtMTEuOWMwLjEtMC4xLDAuMy0wLjMsMC40LTAuNGMwLjUtMS42LDEuNS0yLjgsMi4yLTMuNmMwLjgtMC45LDItMS45LDQuMS0xLjloMCAgICAgYzIsMCwzLjIsMSw0LjEsMS45YzAuNywwLjgsMS43LDIsMi4yLDMuNmMwLjEsMC4xLDAuMywwLjIsMC40LDAuNGMwLjQsMC40LDAuNiwwLjksMC44LDEuNkMzMC45LTkuNywzMS05LjEsMzEtOC42ICAgICBjMCwwLjEsMCwwLjMsMCwwLjRsMCwwYy0wLjEsMC42LTAuMywxLjEtMC42LDEuNWMwLDAtMC4xLDAuMS0wLjEsMC4xYzAuNCwyLjMtMC4zLDYuMy00LjgsNy43Yy0wLjcsMC4yLTEuNCwwLjMtMi4yLDAuMyAgICAgYy0yLjMsMC0zLjgtMS4yLTQuNS0xLjhjLTAuOC0wLjEtMS41LTAuNS0yLjEtMS4yYy0wLjYtMC44LTEuMi0yLjQtMC42LTVjMCwwLDAsMCwwLDBjLTAuNC0wLjQtMC42LTEtMC43LTEuNmMwLTAuMSwwLTAuMywwLTAuNCAgICAgYzAtMC43LDAuMi0xLjUsMC41LTIuMkMxNi0xMS4yLDE2LjItMTEuNiwxNi41LTExLjkiLz4mI3hhOwkJPC9nPiYjeGE7CQk8ZyBpZD0iZzQwOS0wIiB0cmFuc2Zvcm09Im1hdHJpeCgwLjM1Mjc3Nzc3LDAsMCwtMC4zNTI3Nzc3NywyNS4yMTUzNTcsMzkuNjg0MjYzKSI+JiN4YTsJCQk8cGF0aCBpZD0icGF0aDQxMS01IiBjbGFzcz0ic3QwIiBkPSJNMTUuNS00MS40TDE1LjUtNDEuNGwwLDIuN2MwLDAuMy0wLjIsMC41LTAuNSwwLjVjLTAuMywwLTAuNS0wLjItMC41LTAuNXYtMy40ICAgICBjLTEtMC4yLTMuNC0wLjUtNy4xLTAuNWw1LDUuNmMwLjIsMC4yLDAuMiwwLjUsMCwwLjdsLTEsMS40bDEuMywwLjlsMy0wLjljMC40LTAuMSwwLjctMC40LDAuOC0wLjhsMS4yLTUuM0wxNS41LTQxLjR6ICAgICAgTS02LjEtNDEuMWwxLjIsNS4yYzAuMSwwLjQsMC40LDAuNywwLjgsMC45bDMsMC45TDAtMzUuMWwtMS0xLjRjLTAuMi0wLjItMC4xLTAuNSwwLTAuN2w1LTUuNmMtMy42LDAuMS02LjEsMC4zLTcsMC41djMuNCAgICAgYzAsMC4zLTAuMiwwLjUtMC41LDAuNWMtMC4zLDAtMC41LTAuMi0wLjUtMC41di0yLjdMLTYuMS00MS4xeiBNNS4zLTM3bC0wLjUtMi40bC0yLDQuOGwyLTEuM2wtMC4yLTAuMkw1LjMtMzd6IE02LjctMzkuNCAgICAgTDYuMS0zN2wwLjcsMC45bC0wLjIsMC4ybDIsMS4zTDYuNy0zOS40eiBNMS4xLTM0LjVsLTEsMC43bDEuMiwwLjNsMC4xLTAuMWwzLjMtOC4ybC00LjYsNWwxLjEsMS41YzAuMSwwLjEsMC4xLDAuMywwLjEsMC40ICAgICBDMS4zLTM0LjcsMS4yLTM0LjYsMS4xLTM0LjUgTTEwLjItMzUuM2wxLjEtMS41bC00LjQtNC45bDMuMyw4LjFsMC4xLDAuMWwxLjEtMC4zbC0xLTAuN2MtMC4xLTAuMS0wLjItMC4yLTAuMi0wLjMgICAgIEMxMC4xLTM1LDEwLjEtMzUuMiwxMC4yLTM1LjMgTTE4LjUtMzUuM2MtMC4zLDEuMS0xLjEsMi0yLjIsMi4zbC01LjksMS43Yy0wLjMsMC4xLTAuNiwwLTAuOS0wLjFsLTMuOC0yLjVMMi0zMS40ICAgICBjLTAuMywwLjItMC42LDAuMi0wLjksMC4xTC00LjgtMzNjLTEuMS0wLjMtMS45LTEuMi0yLjItMi4zbC0xLjQtNi40Yy0wLjEtMC4zLDAtMC42LDAuMi0wLjhjMC4yLTAuMiwwLjQtMC40LDAuNy0wLjRsMi43LTAuNCAgICAgYzAuNi0wLjcsMi43LTEuMywxMC42LTEuM2M4LDAsMTAuMSwwLjcsMTAuNiwxLjNsMi43LDAuNGMwLjMsMCwwLjUsMC4yLDAuNywwLjRjMC4yLDAuMiwwLjIsMC41LDAuMiwwLjhMMTguNS0zNS4zeiIvPiYjeGE7CQk8L2c+JiN4YTsJCTxnIGlkPSJnNDEzLTciIHRyYW5zZm9ybT0ibWF0cml4KDAuMzUyNzc3NzcsMCwwLC0wLjM1Mjc3Nzc3LDIzLjQ3NjA1NywzNi45MzQ2MDcpIj4mI3hhOwkJCTxwYXRoIGlkPSJwYXRoNDE1LTMiIGNsYXNzPSJzdDAiIGQ9Ik02LjUtMjcuMWMwLjIsMC4yLDAuNCwwLjMsMC42LDAuM2gwYzAuMywwLDAuNywwLjEsMC45LDAuNGMwLDAuMSwxLDEuMiwyLjcsMS4yICAgICBjMC40LDAsMC45LTAuMSwxLjMtMC4yYzMuNS0xLjEsMy00LjQsMi45LTQuN2MwLTAuMSwwLTAuMi0wLjEtMC4zYy0xLjEsMC4yLTIuOCwxLjEtNCwyLjhjLTAuNCwwLjYtMC45LDAuOS0xLjUsMSAgICAgYy0wLjksMC4xLTEuNy0wLjQtMi4zLTAuOWMtMC4zLTAuMi0wLjUtMC41LTAuNi0wLjljLTAuMS0wLjQtMC4zLTAuOC0wLjQtMUM2LTI4LjEsNi4zLTI3LjQsNi41LTI3LjEgTTE1LjUtMzMuMiAgICAgYy0wLjEtMC4zLTAuMi0wLjYtMC40LTAuN0MxNS4xLTM0LDE1LTM0LDE1LTM0Yy0wLjMtMC4xLTAuNS0wLjQtMC41LTAuN2MtMC4yLTAuOS0wLjgtMS45LTEuNi0yLjdjLTAuNy0wLjgtMS4zLTEuMS0yLjItMS4xICAgICB2LTEuMWwwLDEuMWMtMC45LDAtMS41LDAuMy0yLjIsMS4xYy0wLjgsMC44LTEuNCwxLjgtMS42LDIuN2MtMC4xLDAuMy0wLjMsMC41LTAuNSwwLjdjMCwwLTAuMSwwLTAuMSwwLjEgICAgIEM2LjEtMzMuOCw2LTMzLjYsNi0zMy41Yy0wLjIsMC40LTAuMywwLjgtMC4zLDEuMmMwLDAuMSwwLDAuMSwwLDAuMmMwLDAuMiwwLjEsMC4zLDAuMSwwLjNjMCwwLDAsMCwwLjEsMCAgICAgYzAuMywwLjIsMC41LDAuNSwwLjYsMC44YzAuNCwwLjQsMC44LDEuMSwxLjIsMi4xYzAuMSwwLjIsMC4xLDAuMywwLjMsMC40YzAuNSwwLjUsMSwwLjcsMS40LDAuN2MwLjMsMCwwLjUtMC4yLDAuOC0wLjUgICAgIGMxLjMtMS44LDMuNS0zLjIsNS0zLjJjMC4xLTAuMSwwLjItMC4yLDAuNC0wLjNjMCwwLDAuMSwwLDAuMS0wLjFjMC0wLjEsMC4xLTAuMiwwLjEtMC4zdjBjMCwwLDAtMC4xLDAtMC4xICAgICBDMTUuNy0zMi41LDE1LjYtMzIuOSwxNS41LTMzLjIgTTQuNi0zNS4zYzAuMS0wLjEsMC4yLTAuMiwwLjMtMC4zYzAuNS0xLjQsMS4zLTIuNSwyLTMuMmMwLjctMC44LDEuOC0xLjcsMy43LTEuN2gwICAgICBjMS45LDAsMywwLjksMy43LDEuN2MwLjcsMC43LDEuNSwxLjgsMiwzLjJjMC4xLDAuMSwwLjIsMC4yLDAuNCwwLjNjMC4zLDAuNCwwLjYsMC45LDAuOCwxLjVjMC4yLDAuNSwwLjMsMSwwLjMsMS41ICAgICBjMCwwLjEsMCwwLjMsMCwwLjR2MGMtMC4xLDAuNi0wLjMsMS4xLTAuNiwxLjRjMCwwLTAuMSwwLjEtMC4xLDAuMWMwLjMsMi4xLTAuMyw1LjctNC40LDYuOWMtMC43LDAuMi0xLjMsMC4zLTIsMC4zICAgICBjLTIsMC0zLjQtMS00LTEuNmMtMC43LTAuMS0xLjQtMC41LTEuOS0xLjFjLTAuNi0wLjgtMS4xLTIuMi0wLjYtNC42Yy0wLjMtMC40LTAuNS0wLjktMC42LTEuNWMwLTAuMSwwLTAuMywwLTAuNCAgICAgYzAtMC43LDAuMi0xLjQsMC40LTJDNC4yLTM0LjcsNC40LTM1LDQuNi0zNS4zIi8+JiN4YTsJCTwvZz4mI3hhOwkJPGcgaWQ9Imc0MTctMiIgdHJhbnNmb3JtPSJtYXRyaXgoMC4zNTI3Nzc3NywwLDAsLTAuMzUyNzc3NzcsMzAuMDYzMjY1LDM5LjY4NDI2MykiPiYjeGE7CQkJPHBhdGggaWQ9InBhdGg0MTktNyIgY2xhc3M9InN0MCIgZD0iTTQwLjctNDEuNEw0MC43LTQxLjRsMCwyLjdjMCwwLjMtMC4yLDAuNS0wLjUsMC41Yy0wLjMsMC0wLjUtMC4yLTAuNS0wLjV2LTMuNCAgICAgYy0xLTAuMi0zLjQtMC41LTcuMS0wLjVsNSw1LjZjMC4yLDAuMiwwLjIsMC41LDAsMC43bC0xLDEuNGwxLjMsMC45bDMtMC45YzAuNC0wLjEsMC43LTAuNCwwLjgtMC44bDEuMi01LjNMNDAuNy00MS40eiAgICAgIE0xOS4xLTQxLjFsMS4yLDUuMmMwLjEsMC40LDAuNCwwLjcsMC44LDAuOWwzLDAuOWwxLjMtMC45bC0xLTEuNGMtMC4yLTAuMi0wLjEtMC41LDAtMC43bDUtNS42Yy0zLjYsMC4xLTYuMSwwLjMtNywwLjV2My40ICAgICBjMCwwLjMtMC4yLDAuNS0wLjUsMC41Yy0wLjMsMC0wLjUtMC4yLTAuNS0wLjV2LTIuN0wxOS4xLTQxLjF6IE0zMC42LTM3TDMwLTM5LjRsLTIsNC44bDItMS4zbC0wLjItMC4yTDMwLjYtMzd6IE0zMS45LTM5LjQgICAgIEwzMS40LTM3bDAuNywwLjlsLTAuMiwwLjJsMiwxLjNMMzEuOS0zOS40eiBNMjYuMy0zNC41bC0xLDAuN2wxLjIsMC4zbDAuMS0wLjFsMy4zLTguMmwtNC42LDVsMS4xLDEuNWMwLjEsMC4xLDAuMSwwLjMsMC4xLDAuNCAgICAgQzI2LjUtMzQuNywyNi40LTM0LjYsMjYuMy0zNC41IE0zNS40LTM1LjNsMS4xLTEuNWwtNC40LTQuOWwzLjMsOC4xbDAuMSwwLjFsMS4xLTAuM2wtMS0wLjdjLTAuMS0wLjEtMC4yLTAuMi0wLjItMC4zICAgICBDMzUuMy0zNSwzNS4zLTM1LjIsMzUuNC0zNS4zIE00NS4xLTQxLjhsLTEuNSw2LjRjLTAuMywxLjEtMS4xLDItMi4yLDIuM2wtNS45LDEuN2MtMC4zLDAuMS0wLjYsMC0wLjktMC4xTDMxLTMzLjlsLTMuOCwyLjUgICAgIGMtMC4zLDAuMi0wLjYsMC4yLTAuOSwwLjFMMjAuNC0zM2MtMS4xLTAuMy0xLjktMS4yLTIuMi0yLjNsLTEuNC02LjRjLTAuMS0wLjMsMC0wLjYsMC4yLTAuOGMwLjItMC4yLDAuNC0wLjQsMC43LTAuNGwyLjctMC40ICAgICBjMC42LTAuNywyLjctMS4zLDEwLjYtMS4zYzgsMCwxMC4xLDAuNywxMC42LDEuM2wyLjcsMC40YzAuMywwLDAuNSwwLjIsMC43LDAuNEM0NS4yLTQyLjQsNDUuMi00Mi4xLDQ1LjEtNDEuOCIvPiYjeGE7CQk8L2c+JiN4YTsJCTxnIGlkPSJnNDIxLTIiIHRyYW5zZm9ybT0ibWF0cml4KDAuMzUyNzc3NzcsMCwwLC0wLjM1Mjc3Nzc3LDI4LjMyNCwzNi45MzQ2MDcpIj4mI3hhOwkJCTxwYXRoIGlkPSJwYXRoNDIzLTEiIGNsYXNzPSJzdDAiIGQ9Ik0zMS43LTI3LjFjMC4yLDAuMiwwLjQsMC4zLDAuNiwwLjNoMGMwLjMsMCwwLjcsMC4xLDAuOSwwLjRjMCwwLjEsMSwxLjIsMi43LDEuMiAgICAgYzAuNCwwLDAuOS0wLjEsMS4zLTAuMmMzLjUtMS4xLDMtNC40LDIuOS00LjdjMC0wLjEsMC0wLjItMC4xLTAuM2MtMS4xLDAuMi0yLjgsMS4xLTQsMi44Yy0wLjQsMC42LTAuOSwwLjktMS41LDEgICAgIGMtMC45LDAuMS0xLjctMC40LTIuMy0wLjljLTAuMy0wLjItMC41LTAuNS0wLjYtMC45Yy0wLjEtMC40LTAuMy0wLjgtMC40LTFDMzEuMi0yOC4xLDMxLjUtMjcuNCwzMS43LTI3LjEgTTQwLjctMzMuMiAgICAgYy0wLjEtMC4zLTAuMi0wLjYtMC40LTAuN0M0MC4zLTM0LDQwLjItMzQsNDAuMi0zNGMtMC4zLTAuMS0wLjUtMC40LTAuNS0wLjdjLTAuMi0wLjktMC44LTEuOS0xLjYtMi43Yy0wLjctMC44LTEuMy0xLjEtMi4yLTEuMSAgICAgdi0xLjFsMCwxLjFjLTAuOSwwLTEuNSwwLjMtMi4yLDEuMWMtMC44LDAuOC0xLjQsMS44LTEuNiwyLjdjLTAuMSwwLjMtMC4zLDAuNS0wLjUsMC43YzAsMC0wLjEsMC0wLjEsMC4xICAgICBjLTAuMSwwLjEtMC4yLDAuMy0wLjMsMC40Yy0wLjIsMC40LTAuMywwLjgtMC4zLDEuMmMwLDAuMSwwLDAuMSwwLDAuMmMwLDAuMiwwLjEsMC4zLDAuMSwwLjNjMCwwLDAsMCwwLjEsMCAgICAgYzAuMywwLjIsMC41LDAuNSwwLjYsMC44YzAuNCwwLjQsMC44LDEuMSwxLjIsMi4xYzAuMSwwLjIsMC4xLDAuMywwLjMsMC40YzAuNSwwLjUsMSwwLjcsMS40LDAuN2MwLjMsMCwwLjUtMC4yLDAuOC0wLjUgICAgIGMxLjMtMS44LDMuNS0zLjIsNS0zLjJjMC4xLTAuMSwwLjItMC4yLDAuNC0wLjNjMCwwLDAuMSwwLDAuMS0wLjFjMC0wLjEsMC4xLTAuMiwwLjEtMC4zdjBjMCwwLDAtMC4xLDAtMC4xICAgICBDNDAuOS0zMi41LDQwLjgtMzIuOSw0MC43LTMzLjIgTTMwLTI1LjljLTAuNi0wLjgtMS4xLTIuMi0wLjYtNC42Yy0wLjMtMC40LTAuNS0wLjktMC42LTEuNWMwLTAuMSwwLTAuMywwLTAuNCAgICAgYzAtMC43LDAuMi0xLjQsMC40LTJjMC4yLTAuNCwwLjQtMC43LDAuNi0xYzAuMS0wLjEsMC4yLTAuMiwwLjMtMC4zYzAuNS0xLjQsMS4zLTIuNSwyLTMuMmMwLjctMC44LDEuOS0xLjcsMy43LTEuN2gwICAgICBjMS45LDAsMywwLjksMy43LDEuN2MwLjcsMC43LDEuNSwxLjgsMiwzLjJjMC4xLDAuMSwwLjIsMC4yLDAuNCwwLjNjMC4zLDAuNCwwLjYsMC45LDAuOCwxLjVjMC4yLDAuNSwwLjMsMSwwLjMsMS41ICAgICBjMCwwLjEsMCwwLjMsMCwwLjR2MGMtMC4xLDAuNi0wLjMsMS4xLTAuNiwxLjRjMCwwLTAuMSwwLjEtMC4xLDAuMWMwLjMsMi4xLTAuMyw1LjctNC40LDYuOWMtMC43LDAuMi0xLjMsMC4zLTIsMC4zICAgICBjLTIsMC0zLjQtMS00LTEuNkMzMS4yLTI0LjgsMzAuNS0yNS4yLDMwLTI1LjkiLz4mI3hhOwkJPC9nPiYjeGE7CQk8ZyBpZD0iZzQyNS0zIiB0cmFuc2Zvcm09Im1hdHJpeCgwLjM1Mjc3Nzc3LDAsMCwtMC4zNTI3Nzc3NywyNy42NjUzNjQsMzcuNDgwNDYpIj4mI3hhOwkJCTxwYXRoIGlkPSJwYXRoNDI3LTQiIGNsYXNzPSJzdDAiIGQ9Ik0yOC4zLTMwbC0zLjgsMy44di0yLjNoLTQuNnY4LjloLTMuMnYtOC45aC00LjZ2Mi4zTDguMy0zMGwzLjgtMy44djIuM2gxMi4zdi0yLjNMMjguMy0zMHoiLz4mI3hhOwkJPC9nPiYjeGE7CTwvZz4mI3hhOzwvZz4mI3hhOzwvc3ZnPg==" vertex="1" parent="1"><mxGeometry y="-5.684341886080802e-14" width="52" height="52" as="geometry"/></mxCell></root></mxGraphModel>';

# Compress with deflate and then encode with base 64.
my $bufer;
my $d = deflateInit( -WindowBits => -MAX_WBITS);

$bufer  = $d->deflate($code);
$bufer .= $d->flush();

my $out = encode_base64($bufer, '');
# print "Encoded and compressed string: " . $out . "\n\n";        # yes 
print $out;        # yes 
