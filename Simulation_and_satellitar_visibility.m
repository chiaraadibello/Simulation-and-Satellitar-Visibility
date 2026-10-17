% 1. Definizione dell'intervallo temporale della simulazione
startTime = datetime(2026, 10, 17, 12, 0, 0); % inizio
stopTime = startTime + hours(3);              % Durata: 3 ore
sampleTime = 60;                              % Campionamento ogni 60 secondi

% 2.  Scenario Satellitare
sc = satelliteScenario(startTime, stopTime, sampleTime);

% 3. Aggiunta di un Satellite (Orbita LEO - Low Earth Orbit)
% Parametri Kepleriani: [Semi-asse maggiore (m), Eccentricità, Inclinazione (deg), 
% RAAN (deg), Argomento del perigeo (deg), Anomalia vera (deg)]
semiMajorAxis = 6871000; % Circa 500 km di altitudine (R_earth + 500k)
eccentricity = 0.001;
inclination = 53.0;
raan = 0;
argOfPeriapsis = 0;
trueAnomaly = 0;

sat = satellite(sc, semiMajorAxis, eccentricity, inclination, ...
                raan, argOfPeriapsis, trueAnomaly, ...
                'Name', 'Satellitare-LEO', ...
                'OrbitPropagator', 'two-body-keplerian');

% Nota: Puoi anche caricare dati reali tramite file TLE (Two-Line Element):
% sat = satellite(sc, 'tua_constellazione_tle.txt');

% 4. Aggiunta di una Stazione di Terra (es. Roma, Italia)
latStazione = 41.9028;
lonStazione = 12.4964;
groundStationName = 'Stazione-Roma';

gs = groundStation(sc, latStazione, lonStazione, ...
                   'Name', groundStationName, ...
                   'MinElevationAngle', 10); % Angolo minimo di elevazione per il link

% 5. Analisi di Accesso (Visibilità/Finestra di Contatto)
% Calcola quando il satellite è visibile dalla stazione di terra
ac = access(sat, gs);
tabelleAccessi = accessIntervals(ac);

% Mostra i risultati degli intervalli di accesso nella Command Window
disp('--- Finestre di Contatto Calcolate ---');
disp(tabelleAccessi);

% 6. Visualizzazione 3D dello Scenario
v = satelliteScenarioViewer(sc);
show(sat);
show(gs);

% Avvia l'animazione grafica
play(sc);