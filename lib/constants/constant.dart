import 'dart:math';

import 'package:flutter/material.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);
const kDefaultPaddin = 20.0;

const colorPrimary = Color(0xFF006EFA); //#006efa
const colorSecondary = Color.fromARGB(255, 39, 40, 45);

const headerBackground = Color(0xFFFFFFFF);
const headerTextColor = Color(0xFFFFFFFF);
const headerHintText = Color(0xFF848484);
const headerTextColorGreen = Color.fromARGB(255, 46, 142, 12);
const colorCardMenu = Color.fromARGB(255, 176, 178, 186);

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256), // Rojo
    random.nextInt(256), // Verde
    random.nextInt(256), // Azul
  );
}

const helpText = "Seleccionar fecha de nacimiento";
const cancelText = "Cancelar";
const confirmText = "Aceptar";

const startText = "Inicio";
const searchText = "Buscar Usuarios";
const creaUserText = "Crear Usuarios";

const introTitle = "Gestión de usuarios";
const description =
    "Nuestro sistema te permite recopilar datos de usuarios o personas con diversar direcciones, las cuales puedes realizar procesamiento con IA integrado con n8n para tener un proceso automatizado y poder notificar las eventualidades para la toma desiciones";

const nameText = "Nombre";
const lastNameText = "Apellido";
const birthdateText = "Fecha de nacimiento";
const addAddressText = "Agregar dirección";

const streetAddressText = "Dirección";
const cityText = "Ciudad";
const stateProvinceText = "Departamento o Provincia";
const postalCodeText = "Código Postal";
const countryText = "País";
const hintextAddress = "Calle # 10 - 30";
const textSave = "Registrar Usuario";
const textSaveAddress = "Guardar";
const textAddress = "dirección (es)";
const textUserRegistered = "Usuario registrado";
const textAddressRegistered = "Dirección (es) registrada(s)";
const textManagamentUser = "Gestionar Usuarios";

const notFoundUserText = "No hay usuarios registrados.";
const notFoundAddressText = "No hay direcciones registradas.";
const titleNotification = "Notificación";

const baseUrlCountry = "https://restcountries.com/v3.1/all?fields=name,cca2";
const textSearchCountry = "Buscar país";
const textNotFoundCountry = "No se encontraron países";
